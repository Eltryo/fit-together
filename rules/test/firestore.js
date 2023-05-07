const test = require("@firebase/rules-unit-testing");
const {getDocs, deleteDoc, updateDoc, getDoc, setDoc, doc, collection, query, where} = require("firebase/firestore")
const fs = require('fs')
const {
    userSetTests,
    usersGetTests,
    userUpdateTests,
    userDeleteTests,
    postsGetTests,
    postsDeleteTests
} = require("./testData")

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

        describe.only("update requests", () => {
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
    })

    describe("posts collection tests", () => {
        describe("update requests", () => {
            postsGetTests.forEach(({description, setupData, uid, assert}) => {
                it(description, async () => {
                    await setup(setupData)
                    const user = uid == null ? testEnv.unauthenticatedContext() : testEnv.authenticatedContext(uid)
                    const q = query(collection(user.firestore(), "posts"), where("ownerId", "==", uid))
                    await assert(getDocs(q))
                })
            })
        })

        describe("delete requests", () => {
            postsDeleteTests.forEach(({description, setupData, uid, assert}) => {
                it(description, async () => {
                    await setup(setupData)
                    const user = uid == null ? testEnv.unauthenticatedContext() : testEnv.authenticatedContext(uid)
                    const q = query(collection(user.firestore(), "posts"), where("ownerId", "==", uid))
                    const querySnapshot = await getDocs(q)
                    querySnapshot.forEach(doc => {
                        assert(deleteDoc(doc.ref))
                    })
                })
            })
        })
    })
})
