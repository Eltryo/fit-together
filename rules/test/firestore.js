const firebase = require("@firebase/testing");
// const sinon = require("sinon")

const FIREBASE_PROJECT_ID = "fit-together-74181";
const myAuthUid = "cVV9YzdhqTSH0vr4YI4IzhzjroH3";
const otherAuthUid = "fW6YDKz1uwhAglNhF8Lb6HKqzwm2";
const myAuth = {uid: myAuthUid, email: "david.merkl.dm@gmail.com"};
const otherAuth = {uid: otherAuthUid, email: "max.mustermann@gmail.com"};

describe("firestore tests", () => {
    function getFireStore(myAuth, data = null) {
        const db = firebase.initializeTestApp({projectId: FIREBASE_PROJECT_ID, auth: myAuth,}).firestore()
        if (data) {
            for (const key in data) {
                const ref = db.doc(key)
                ref.set(data[key])
            }
        }

        return db
    }

    beforeEach(async () => {
        await firebase.clearFirestoreData({projectId: FIREBASE_PROJECT_ID})
    })

    describe("users collection tests", () => {
        it('should get user document', async () => {
                const db = getFireStore(myAuth)
                const doc = db.collection("users").doc("cVV9YzdhqTSH0vr4YI4IzhzjroH3")
                await firebase.assertSucceeds(doc.get());
            }
        );

        it('should not get user document from false user', async () => {
                const db = getFireStore(myAuth)
                const doc = db.collection("users").doc("fW6YDKz1uwhAglNhF8Lb6HKqzwm2")
                await firebase.assertFails(doc.get());
            }
        );

        it('should not get user document without authentication', async () => {
                const db = getFireStore(myAuth)
                const doc = db.collection("users").doc("fW6YDKz1uwhAglNhF8Lb6HKqzwm2")
                await firebase.assertFails(doc.get());
            }
        );

        it('should not create user document without authentication', async () => {
                const db = getFireStore(null)
                const doc = db.collection("users").doc("cVV9YzdhqTSH0vr4YI4IzhzjroH3")
                await firebase.assertFails(doc.set({foo: "bar"}));
            }
        );
    })

    describe("posts collection tests", () => {
        //TODO: write more tests
        it('should not get user document without authentication', async () => {
                const db = getFireStore(null)
                const doc = db.collection("posts").doc("doc")
                await firebase.assertFails(doc.get());
            }
        );

        it('should get own user document', async () => {
                const db = getFireStore(myAuth)
                const doc = db.collection("posts").where("ownerId", "==", myAuthUid)
                await firebase.assertSucceeds(doc.get());
            }
        );

        it('should get public user document', async () => {
                //TODO: fix failing test
                const mockData = {
                    myAuthUid: {
                        username: "Eltryo",
                        email: "david.merkl.dm@gmail.com",
                        appUserStats: {},
                        visibility: "public"
                    }
                }
                const db = getFireStore(myAuth, mockData)
                // const userDoc = await db.collection("users").doc(otherAuthUid).get()
                // sinon.stub(userDoc, "exists").returns(true)
                // sinon.stub(userDoc, "get").withArgs("visibility").returns("public")
                const doc = db.collection("posts")
                    .where("ownerId", "==", otherAuthUid)
                await firebase.assertFails(doc.get());
            }
        );
    })
})