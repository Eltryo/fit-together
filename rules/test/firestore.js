const firebase = require("@firebase/testing");
const fs = require("fs");

const FIREBASE_PROJECT_ID = "fit-together-74181";
const myAuthUid = "cVV9YzdhqTSH0vr4YI4IzhzjroH3";
const otherAuthUid = "fW6YDKz1uwhAglNhF8Lb6HKqzwm2";
const myAuth = {uid: myAuthUid, email: "david.merkl.dm@gmail.com", firebase: {sign_in_provider: "password"}};
const otherAuth = {uid: otherAuthUid, email: "max.mustermann@gmail.com", firebase: {sign_in_provider: "anonymous"}};

describe("firestore tests", async () => {
    async function setup(myAuth, data = null) {
        const db = firebase.initializeTestApp({projectId: FIREBASE_PROJECT_ID, auth: myAuth,}).firestore()
        if (data) {
            const adminDb = firebase.initializeAdminApp({projectId: FIREBASE_PROJECT_ID}).firestore()
            for (const key in data) {
                await adminDb.doc(key).set(data[key])
            }
        }

        return db
    }

    beforeEach(async () => {
        await firebase.clearFirestoreData({projectId: FIREBASE_PROJECT_ID})
    })

    describe("users collection tests", () => {
        describe("get request", () => {
            it('should not get user document from false user', async () => {
                    const db = await setup(myAuth)
                    const doc = db.collection("users").doc(otherAuthUid)
                    await firebase.assertFails(doc.get());
                }
            );

            it('should get user document', async () => {
                    const db = await setup(myAuth)
                    const doc = db.collection("users").doc(myAuthUid)
                    await firebase.assertSucceeds(doc.get());
                }
            );

            it('should not get user document without authentication', async () => {
                    const db = await setup(null)
                    const doc = db.collection("users").doc(otherAuthUid)
                    await firebase.assertFails(doc.get());
                }
            );

            it('should get public user document', async () => {
                    const userDocPath = `users/${otherAuthUid}`
                    const mockData = {
                        [userDocPath]: {
                            username: "Eltryo123",
                            email: "david.merkl.dm@gmail.com",
                            appUserStats: {foo: "bar"},
                            visibility: "public"
                        }
                    }
                    const db = await setup(myAuth, mockData)
                    const doc = db.collection("users").doc(otherAuthUid)
                    await firebase.assertSucceeds(doc.get());
                }
            );

            it('should not get private user document', async () => {
                    const userDocPath = `users/${otherAuthUid}`
                    const mockData = {
                        [userDocPath]: {
                            username: "Eltryo123",
                            email: "david.merkl.dm@gmail.com",
                            appUserStats: {},
                            visibility: "private"
                        }
                    }
                    const db = await setup(myAuth, mockData)
                    const doc = db.collection("users").doc(otherAuthUid)
                    await firebase.assertFails(doc.get());
                }
            );
        })

        describe("update requests", () => {
            it('should not update to invalid username', async () => {
                const db = await setup(myAuth)
                const doc = db.collection("users").doc(myAuthUid)
                await firebase.assertFails(doc.update({
                    "username": "_Eltryo"
                }));
            })

            it('should not update to invalid email', async () => {
                const db = await setup(myAuth)
                const doc = db.collection("users").doc(myAuthUid)
                await firebase.assertFails(doc.update({
                    "email": "david.merkl.dm@gmailcom"
                }));
            })

            it('should not update to user with false field types', async () => {
                const db = await setup(myAuth)
                const doc = db.collection("users").doc(myAuthUid)
                await firebase.assertFails(doc.update({
                    "visibility": true
                }));
            })
        })

        describe("delete request", () => {
            it('should not delete user without authentication', async () => {
                const db = await setup(null)
                const doc = db.collection("users").doc(myAuthUid)
                await firebase.assertFails(doc.delete());
            });

            it('should not delete user without authorization', async () => {
                const db = await setup(myAuth)
                const doc = db.collection("users").doc(otherAuthUid)
                await firebase.assertFails(doc.delete());
            });
        })

        describe("post request", () => {
            it('should not create invalid username', async () => {
                const db = await setup(myAuth)
                const doc = db.collection("users").doc(myAuthUid)
                await firebase.assertFails(doc.set({
                    username: "_Eltryo123",
                    email: "david.merkl.dm@gmail.com",
                    appUserStats: {},
                    visibility: "public"
                }));
            })

            it('should not create invalid email', async () => {
                const db = await setup(myAuth)
                const doc = db.collection("users").doc(myAuthUid)
                await firebase.assertFails(doc.set({
                    username: "Eltryo123",
                    email: "david.merkl.dmgmail.com",
                    appUserStats: {},
                    visibility: "public"
                }));
            })

            it('should not create user document without authentication', async () => {
                    const db = await setup(null)
                    const doc = db.collection("users").doc(myAuthUid)
                    await firebase.assertFails(doc.set({
                        username: "Eltryo",
                        email: "david.merkl.dm@gmail.com",
                        appUserStats: {},
                        visibility: "public"
                    }));
                }
            );

            it('should not create user document with false fields', async () => {
                    const db = await setup(myAuth)
                    const doc = db.collection("users").doc(myAuthUid)
                    await firebase.assertFails(doc.set({foo: "bar"}));
                }
            );

            it('should not create user document with false field types', async () => {
                    const db = await setup(myAuth)
                    const doc = db.collection("users").doc(myAuthUid)
                    await firebase.assertFails(doc.set({
                        username: "Eltryo",
                        email: "david.merkl.dm@gmail.com",
                        appUserStats: "",
                        visibility: "public"
                    }));
                }
            );

            it('should not create user document with anonymous auth method', async () => {
                    const db = await setup(otherAuth)
                    const doc = db.collection("users").doc(otherAuthUid)
                    await firebase.assertFails(doc.set({
                        username: "Eltryo1234",
                        email: "david.merkl.dm@gmail.com",
                        appUserStats: {},
                        visibility: "public"
                    }));
                }
            );
        })
    })

    describe("posts collection tests", () => {
        //TODO: write more tests
        describe("get request", () => {
            it('should not get user document without authentication', async () => {
                    const db = await setup(null)
                    const doc = db.collection("posts").doc("doc")
                    await firebase.assertFails(doc.get());
                }
            );

            it('should get own user document', async () => {
                    const db = await setup(myAuth)
                    const doc = db.collection("posts").where("ownerId", "==", myAuthUid)
                    await firebase.assertSucceeds(doc.get());
                }
            );

            it('should get public user document', async () => {
                    const userDocPath = `users/${otherAuthUid}`
                    const postDocPath = `posts/ `
                    const mockData = {
                        [userDocPath]: {
                            username: "Eltryo",
                            email: "david.merkl.dm@gmail.com",
                            appUserStats: {},
                            visibility: "public"
                        },
                        [postDocPath]: {
                            path: "",
                            ownerId: otherAuthUid
                        }
                    }
                    const db = await setup(myAuth, mockData)
                    const doc = db.collection("posts")
                        .where("ownerId", "==", otherAuthUid)
                    await firebase.assertSucceeds(doc.get());
                }
            );
        })

        describe("delete request", () => {
            it('should not delete post without authentication', async () => {
                const db = await setup(null)
                const doc = db.collection("posts").doc(myAuthUid)
                await firebase.assertFails(doc.delete());
            });

            it('should not delete post without authorization', async () => {
                const db = await setup(myAuth)
                const doc = db.collection("posts").doc(otherAuthUid)
                await firebase.assertFails(doc.delete());
            });
        })
    })
})