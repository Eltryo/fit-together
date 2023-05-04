const test = require("@firebase/rules-unit-testing");
const {deleteDoc, updateDoc, getDoc, setDoc, doc} = require("firebase/firestore")
const fs = require('fs')
const {setTests, getTests, updateTests, deleteTests} = require("./testData")

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
            projectId: "fit-together-74181",
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
            getTests.forEach(({description, setupData, uid, docId, assert}) => {
                it(description, async () => {
                    await setup(setupData);
                    const user = uid == null ? testEnv.unauthenticatedContext() : testEnv.authenticatedContext(uid)
                    await assert(getDoc(doc(user.firestore(), `users/${docId}`)))
                })
            })
        })

        describe("update requests", () => {
            updateTests.forEach(({description, setupData, updateData, uid, docId, assert}) => {
                it(description, async () => {
                    await setup(setupData);
                    const user = uid == null ? testEnv.unauthenticatedContext() : testEnv.authenticatedContext(uid)
                    await assert(updateDoc(doc(user.firestore(), `user/${docId}`), updateData))
                })
            })
        })

        describe("delete requests", () => {
            deleteTests.forEach(({description, setupData, uid, docId, assert}) => {
                it(description, async () => {
                    await setup(setupData);
                    const user = uid == null ? testEnv.unauthenticatedContext() : testEnv.authenticatedContext(uid)
                    await assert(deleteDoc(doc(user.firestore(), `user/${docId}`)))
                })
            })
        })

        describe("post requests", () => {
            setTests.forEach(({description, setData, auth, docId, assert}) => {
                it(description, async () => {
                    const user = auth == null ? testEnv.unauthenticatedContext() : testEnv.authenticatedContext(auth.sub)
                    await assert(setDoc(doc(user.firestore(), `user/${docId}`), setData))
                })
            })
        })

        // describe("posts collection updateTests", () => {
        //     //TODO: write more updateTests
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
