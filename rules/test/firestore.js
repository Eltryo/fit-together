const test = require("@firebase/rules-unit-testing");
const {getDocs, deleteDoc, updateDoc, getDoc, setDoc, doc, collection, query, where} = require("firebase/firestore")
const fs = require('fs')
const {userSetTests, usersGetTests, userUpdateTests, userDeleteTests, postsGetTests} = require("./testData")

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
            usersGetTests.forEach(({description, setupData, uid, docId, assert}) => {
                it(description, async () => {
                    await setup(setupData);
                    const user = uid == null ? testEnv.unauthenticatedContext() : testEnv.authenticatedContext(uid)
                    await assert(getDoc(doc(user.firestore(), `users/${docId}`)))
                })
            })
        })

        describe("update requests", () => {
            userUpdateTests.forEach(({description, setupData, updateData, uid, docId, assert}) => {
                it(description, async () => {
                    await setup(setupData);
                    const user = uid == null ? testEnv.unauthenticatedContext() : testEnv.authenticatedContext(uid)
                    await assert(updateDoc(doc(user.firestore(), `users/${docId}`), updateData))
                })
            })
        })

        describe("delete requests", () => {
            userDeleteTests.forEach(({description, setupData, uid, docId, assert}) => {
                it(description, async () => {
                    await setup(setupData);
                    const user = uid == null ? testEnv.unauthenticatedContext() : testEnv.authenticatedContext(uid)
                    await assert(deleteDoc(doc(user.firestore(), `users/${docId}`)))
                })
            })
        })

        describe("post requests", () => {
            userSetTests.forEach(({description, setData, auth, docId, assert}) => {
                it(description, async () => {
                    const user = auth == null ? testEnv.unauthenticatedContext() : testEnv.authenticatedContext(auth.sub)
                    await assert(setDoc(doc(user.firestore(), `users/${docId}`), setData))
                })
            })
        })

        describe.only("posts collection updateTests", () => {
            postsGetTests.forEach(({description, setupData, uid, assert}) => {
                it(description, async () => {
                    await setup(setupData)
                    const user = uid == null ? testEnv.unauthenticatedContext() : testEnv.authenticatedContext(uid)
                    const q = query(collection(user.firestore(), "posts"), where("ownerId", "==", uid))
                    await assert(getDocs(q))
                })
            })
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
        })
    })
})
