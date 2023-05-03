const test = require("@firebase/rules-unit-testing");
const {getDoc, setDoc, doc} = require("firebase/firestore")
const fs = require('fs')

const FIREBASE_PROJECT_ID = "fit-together-74181";
const myAuthUid = "cVV9YzdhqTSH0vr4YI4IzhzjroH3";
const otherAuthUid = "fW6YDKz1uwhAglNhF8Lb6HKqzwm2";
const myAuth = {uid: myAuthUid, email: "david.merkl.dm@gmail.com", firebase: {sign_in_provider: "password"}};
const otherAuth = {uid: otherAuthUid, email: "max.mustermann@gmail.com", firebase: {sign_in_provider: "anonymous"}};

let testEnv

describe("firestore tests", async () => {
    async function setup(data) {
        if (data) {
            for (const key in data) {
                await testEnv.withSecurityRulesDisabled(async (context) => {
                    await setDoc(doc(context.firestore(), key), data[key])
                })
            }
        }
    }

    before(async () => {
        testEnv = await test.initializeTestEnvironment({
            projectId: FIREBASE_PROJECT_ID,
            firestore: {
                rules: fs.readFileSync('/home/david/AndroidStudioProjects/fit-together/rules/firestore.rules', 'utf-8'),
                port: 8080,
                host: 'localhost'
            }
        })
    })

    after(async () => {
        await testEnv.cleanup()
    })

    beforeEach(async () => {
        await testEnv.clearFirestore()
    })

    describe("users collection tests", () => {
        describe("get request", () => {
            const tests = [
                {
                    description: "shout not get user document from false user",
                    mockData:
                        {
                            [`users/${otherAuthUid}`]: {
                                username: "Eltryo123",
                                email: "david.merkl.dm@gmail.com",
                                appUserStats: {},
                                visibility: "private"
                            }
                        }
                    ,
                    auth: myAuthUid,
                    docId: otherAuthUid,
                    assert: test.assertFails
                },
                {
                    description: "should not get user document without authentication",
                    mockData:
                        {
                            [`users/${myAuthUid}`]: {
                                username: "Eltryo123",
                                email: "david.merkl.dm@gmail.com",
                                appUserStats: {},
                                visibility: "private"
                            }
                        }
                    ,
                    auth: null,
                    docId: myAuthUid,
                    assert: test.assertFails
                },
                {
                    description: "should not get private user document",
                    mockData:
                        {
                            [`users/${otherAuthUid}`]: {
                                username: "Eltryo123",
                                email: "david.merkl.dm@gmail.com",
                                appUserStats: {},
                                visibility: "private"
                            }
                        }
                    ,
                    auth: myAuth,
                    docId: otherAuthUid,
                    assert: test.assertFails
                },
                //TODO: fix this shit
                {
                    description: "should get user document",
                    mockData:
                        {
                            [`users/${myAuthUid}`]: {
                                username: "Eltryo123",
                                email: "david.merkl.dm@gmail.com",
                                appUserStats: {},
                                visibility: "private"
                            }
                        }
                    ,
                    auth: myAuth,
                    docId: myAuthUid,
                    assert: test.assertSucceeds
                },
                {
                    description: "should get public user document",
                    mockData:
                        {
                            [`users/${otherAuthUid}`]: {
                                username: "Eltryo123",
                                email: "david.merkl.dm@gmail.com",
                                appUserStats: {},
                                visibility: "public"
                            }
                        }
                    ,
                    auth: myAuth,
                    docId: otherAuthUid,
                    assert: test.assertSucceeds
                },
            ]

            tests.forEach(({description, mockData, auth, docId, assert}) => {
                it(description, async () => {
                    await setup(mockData);
                    const user = auth == null ? testEnv.unauthenticatedContext() : testEnv.authenticatedContext(auth)
                    await assert(getDoc(doc(user.firestore(), `users/${docId}`)))
                })
            })
        })

        describe("update requests", () => {
            const tests = [
                {
                    description: "should update to valid username",
                    mockData:
                        {
                            [`users/${myAuthUid}`]: {
                                username: "Eltryo",
                                email: "david.merkl.dm@gmail.com",
                                appUserStats: {},
                                visibility: "public"
                            }
                        }
                    ,
                    updateData: {username: "Eltryo123"},
                    auth: myAuthUid,
                    docId: myAuthUid,
                    assert: test.assertSucceeds
                },
                {
                    description: "should not update to invalid username",
                    mockData:
                        {
                            [`users/${myAuthUid}`]: {
                                username: "Eltryo123",
                                email: "david.merkl.dm@gmail.com",
                                appUserStats: {},
                                visibility: "private"
                            }
                        }
                    ,
                    updateData: {username: "_Eltryo"},
                    auth: myAuth,
                    docId: myAuthUid,
                    assert: test.assertFails
                },
                {
                    description: "should not update to invalid email",
                    mockData:
                        {
                            [`users/${myAuthUid}`]: {
                                username: "Eltryo123",
                                email: "david.merkl.dm@gmail.com",
                                appUserStats: {},
                                visibility: "private"
                            }
                        }
                    ,
                    updateData: {email: "david.merkl.dm@gmail.com"},
                    auth: myAuth,
                    docId: myAuthUid,
                    assert: test.assertFails
                },
                {
                    description: "should not update to user with false field types",
                    mockData:
                        {
                            [`users/${myAuthUid}`]: {
                                username: "Eltryo123",
                                email: "david.merkl.dm@gmail.com",
                                appUserStats: {},
                                visibility: "public"
                            }
                        }
                    ,
                    updateData: {visibility: true},
                    auth: myAuth,
                    docId: myAuthUid,
                    assert: test.assertFails
                },
                {
                    description: "should not update to appUserStats",
                    mockData:
                        {
                            [`users/${myAuthUid}`]: {
                                username: "Eltryo123",
                                email: "david.merkl.dm@gmail.com",
                                appUserStats: {},
                                visibility: "public"
                            }
                        }
                    ,
                    updateData: {appUserStats: {foo: "bar"}},
                    auth: myAuth,
                    docId: myAuthUid,
                    assert: test.assertFails
                },
            ]

            tests.forEach(({description, mockData, updateData, auth, docId, assert}) => {
                it(description, async () => {
                    await setup(mockData);
                    const user = auth == null ? testEnv.unauthenticatedContext() : testEnv.authenticatedContext(auth)
                    await assert(user.firestore().doc(`users/${docId}`).update(updateData))
                })
            })

            //     describe("delete request", () => {
            //         it('should not delete user without authentication', async () => {
            //             await setup(null)
            //             const doc = db.collection("users").doc(myAuthUid)
            //             await test.assertFails(doc.delete());
            //         });
            //
            //         it('should not delete user without authorization', async () => {
            //             await setup(myAuth)
            //             const doc = db.collection("users").doc(otherAuthUid)
            //             await test.assertFails(doc.delete());
            //         });
            //     })
            //
            //     describe("post request", () => {
            //         it('should not create invalid username', async () => {
            //             await setup(myAuth)
            //             const doc = db.collection("users").doc(myAuthUid)
            //             await test.assertFails(doc.set({
            //                 username: "_Eltryo123",
            //                 email: "david.merkl.dm@gmail.com",
            //                 appUserStats: {},
            //                 visibility: "public"
            //             }));
            //         })
            //
            //         it('should not create invalid email', async () => {
            //             await setup(myAuth)
            //             const doc = db.collection("users").doc(myAuthUid)
            //             await test.assertFails(doc.set({
            //                 username: "Eltryo123",
            //                 email: "david.merkl.dmgmail.com",
            //                 appUserStats: {},
            //                 visibility: "public"
            //             }));
            //         })
            //
            //         it('should not create user document without authentication', async () => {
            //                 await setup(null)
            //                 const doc = db.collection("users").doc(myAuthUid)
            //                 await test.assertFails(doc.set({
            //                     username: "Eltryo",
            //                     email: "david.merkl.dm@gmail.com",
            //                     appUserStats: {},
            //                     visibility: "public"
            //                 }));
            //             }
            //         );
            //
            //         it('should not create user document with false fields', async () => {
            //                 await setup(myAuth)
            //                 const doc = db.collection("users").doc(myAuthUid)
            //                 await test.assertFails(doc.set({foo: "bar"}));
            //             }
            //         );
            //
            //         it('should not create user document with false field types', async () => {
            //                 await setup(myAuth)
            //                 const doc = db.collection("users").doc(myAuthUid)
            //                 await test.assertFails(doc.set({
            //                     username: "Eltryo",
            //                     email: "david.merkl.dm@gmail.com",
            //                     appUserStats: "",
            //                     visibility: "public"
            //                 }));
            //             }
            //         );
            //
            //         it('should not create user document with anonymous auth method', async () => {
            //                 await setup(otherAuth)
            //                 const doc = db.collection("users").doc(otherAuthUid)
            //                 await test.assertFails(doc.set({
            //                     username: "Eltryo1234",
            //                     email: "david.merkl.dm@gmail.com",
            //                     appUserStats: {},
            //                     visibility: "public"
            //                 }));
            //             }
            //         );
            //     })
            // })
            //
            // describe("posts collection tests", () => {
            //     //TODO: write more tests
            //     describe("get request", () => {
            //         it('should not get user document without authentication', async () => {
            //                 await setup(null)
            //                 const doc = db.collection("posts").doc("doc")
            //                 await test.assertFails(doc.get());
            //             }
            //         );
            //
            //         it('should get own user document', async () => {
            //                 await setup(myAuth)
            //                 const doc = db.collection("posts").where("ownerId", "==", myAuthUid)
            //                 await test.assertSucceeds(doc.get());
            //             }
            //         );
            //
            //         it('should get public user document', async () => {
            //                 const userDocPath = `users/${otherAuthUid}`
            //                 const postDocPath = `posts/ `
            //                 const mockData = {
            //                     [userDocPath]: {
            //                         username: "Eltryo",
            //                         email: "david.merkl.dm@gmail.com",
            //                         appUserStats: {},
            //                         visibility: "public"
            //                     },
            //                     [postDocPath]: {
            //                         path: "",
            //                         ownerId: otherAuthUid
            //                     }
            //                 }
            //                 await setup(myAuth, mockData)
            //                 const doc = db.collection("posts")
            //                     .where("ownerId", "==", otherAuthUid)
            //                 await test.assertSucceeds(doc.get());
            //             }
            //         );
            //     })
            //
            //     describe("delete request", () => {
            //         it('should not delete post without authentication', async () => {
            //             await setup(null)
            //             const doc = db.collection("posts").doc(myAuthUid)
            //             await test.assertFails(doc.delete());
            //         });
            //
            //         it('should not delete post without authorization', async () => {
            //             await setup(myAuth)
            //             const doc = db.collection("posts").doc(otherAuthUid)
            //             await test.assertFails(doc.delete());
            //         });
            //     })
        })
    })
})
