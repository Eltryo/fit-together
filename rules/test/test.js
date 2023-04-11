const firebase = require("@firebase/testing");
const assert = require("assert");
const FIREBASE_PROJECT_ID = "fit-together-74181";
const myAuth = {uid: "cVV9YzdhqTSH0vr4YI4IzhzjroH3", email: "david.merkl.dm@gmail.com"}

describe("firestore tests", () => {
    const testUser = {
        username: "david",
        email: "david.merkl.dm@gmail.com",
        appUserStats: {
            "pictureCount": 0,
            "followingCount": 0,
            "followerCount": 0
        }
    }

    function getFireStore(myAuth) {
        return firebase.initializeTestApp({projectId: FIREBASE_PROJECT_ID, auth: myAuth}).firestore()
    }

    beforeEach(async () => {
        await firebase.clearFirestoreData({projectId: FIREBASE_PROJECT_ID})
    })

    describe("users collection tests",() => {
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

        it('should get public user document', async () => {
                const db = getFireStore(myAuth)
                const doc = db.collection("posts").where("visibility", "==", "public")
                await firebase.assertSucceeds(doc.get());
            }
        );
    })
})