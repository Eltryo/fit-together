const test = require("@firebase/rules-unit-testing");

const myAuthUid = "cVV9YzdhqTSH0vr4YI4IzhzjroH3";
const otherAuthUid = "fW6YDKz1uwhAglNhF8Lb6HKqzwm2";
const myAuth = {sub: myAuthUid, email: "david.merkl.dm@gmail.com", firebase: {sign_in_provider: "password"}};
const otherAuth = {sub: otherAuthUid, email: "max.mustermann@gmail.com", firebase: {sign_in_provider: "anonymous"}};

exports.usersGetTests = [
    {
        description: "should not get user document without authentication",
        setupData:
            {
                [`users/${myAuthUid}`]: {
                    username: "Eltryo123",
                    email: "david.merkl.dm@gmail.com",
                    appUserStats: {},
                    visibility: "private"
                }
            }
        ,
        uid: null,
        docId: myAuthUid,
        assert: test.assertFails
    },
    {
        description: "should not get private user document",
        setupData:
            {
                [`users/${otherAuthUid}`]: {
                    username: "Eltryo123",
                    email: "david.merkl.dm@gmail.com",
                    appUserStats: {},
                    visibility: "private"
                }
            }
        ,
        uid: myAuthUid,
        docId: otherAuthUid,
        assert: test.assertFails
    },
    {
        description: "should get user document",
        setupData:
            {
                [`users/${myAuthUid}`]: {
                    username: "Eltryo123",
                    email: "david.merkl.dm@gmail.com",
                    appUserStats: {},
                    visibility: "private"
                }
            }
        ,
        uid: myAuthUid,
        docId: myAuthUid,
        assert: test.assertSucceeds
    },
    {
        description: "should get public user document",
        setupData:
            {
                [`users/${otherAuthUid}`]: {
                    username: "Eltryo123",
                    email: "david.merkl.dm@gmail.com",
                    appUserStats: {},
                    visibility: 'public'
                }
            }
        ,
        uid: myAuthUid,
        docId: otherAuthUid,
        assert: test.assertSucceeds
    },
]

exports.userUpdateTests = [
    {
        description: "should update to valid username",
        setupData:
            {
                [`users/${myAuthUid}`]: {
                    username: "Eltryo123",
                    email: "david.merkl.dm@gmail.com",
                    appUserStats: {},
                    visibility: "public"
                }
            }
        ,
        updateData: {username: "Eltryo123_"},
        uid: myAuthUid,
        assert: test.assertSucceeds
    },
    {
        description: "should not update to invalid username",
        setupData:
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
        uid: myAuthUid,
        docId: myAuthUid,
        assert: test.assertFails
    },
    {
        description: "should not update to invalid email",
        setupData:
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
        uid: myAuthUid,
        docId: myAuthUid,
        assert: test.assertFails
    },
    {
        description: "should not update to user with false field types",
        setupData:
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
        uid: myAuthUid,
        docId: myAuthUid,
        assert: test.assertFails
    },
    {
        description: "should not update to appUserStats",
        setupData:
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
        uid: myAuthUid,
        docId: myAuthUid,
        assert: test.assertFails
    },
]

exports.userDeleteTests = [
    {
        description: "should not delete user without authentication",
        setupData:
            {
                [`users/${myAuthUid}`]: {
                    username: "Eltryo123",
                    email: "david.merkl.dm@gmail.com",
                    appUserStats: {},
                    visibility: "public"
                }
            }
        ,
        uid: null,
        docId: myAuthUid,
        assert: test.assertFails
    },
    {
        description: "should not delete other user",
        setupData:
            {
                [`users/${otherAuthUid}`]: {
                    username: "Eltryo123",
                    email: "david.merkl.dm@gmail.com",
                    appUserStats: {},
                    visibility: "public"
                }
            }
        ,
        uid: myAuthUid,
        docId: otherAuthUid,
        assert: test.assertFails
    }
]

exports.userSetTests = [
    {
        description: "should not create invalid username",
        setData:
            {
                [`users/${myAuthUid}`]: {
                    username: "_Eltryo",
                    email: "david.merkl.dm@gmail.com",
                    appUserStats: {},
                    visibility: "public"
                }
            }
        ,
        auth: myAuth,
        docId: myAuthUid,
        assert: test.assertFails
    },
    {
        description: "should not create invalid email",
        setData:
            {
                [`users/${myAuthUid}`]: {
                    username: "_Eltryo",
                    email: "david.merkl.dm@gmailcom",
                    appUserStats: {},
                    visibility: "public"
                }
            }
        ,
        auth: myAuth,
        docId: myAuthUid,
        assert: test.assertFails
    },
    {
        description: "should not create user document without authentication",
        setData:
            {
                [`users/${myAuthUid}`]: {
                    username: "_Eltryo",
                    email: "david.merkl.dm@gmail.com",
                    appUserStats: {},
                    visibility: "public"
                }
            }
        ,
        auth: null,
        docId: myAuthUid,
        assert: test.assertFails
    },
    {
        description: "should not create user document with false fields",
        setData:
            {
                [`users/${myAuthUid}`]: {
                    foo: "bar"
                }
            }
        ,
        auth: myAuth,
        docId: myAuthUid,
        assert: test.assertFails
    },
    {
        description: "should not create user document with false field types",
        setData:
            {
                [`users/${myAuthUid}`]: {
                    username: "_Eltryo",
                    email: "david.merkl.dm@gmail.com",
                    appUserStats: "",
                    visibility: "public"
                }
            }
        ,
        auth: myAuth,
        docId: myAuthUid,
        assert: test.assertFails
    },
    {
        description: "should not create user document with anonymous auth method",
        setData:
            {
                [`users/${myAuthUid}`]: {
                    username: "_Eltryo",
                    email: "david.merkl.dm@gmail.com",
                    appUserStats: {},
                    visibility: "public"
                }
            }
        ,
        auth: otherAuth,
        docId: otherAuthUid,
        assert: test.assertFails
    },
]

exports.postsGetTests = [
    {
        description: "should not get user document without authentication",
        setupData:
            {
                [`users/${myAuthUid}`]: {
                    username: "Eltryo",
                    email: "david.merkl.dm@gmail.com",
                    appUserStats: {},
                    visibility: "public"
                },
                [`posts/doc`]: {
                    path: "",
                    ownerId: myAuthUid
                }
            }
        ,
        uid: null,
        assert: test.assertFails
    },
    {
        description: "should get own user document",
        setupData:
            {
                [`users/${myAuthUid}`]: {
                    username: "Eltryo",
                    email: "david.merkl.dm@gmail.com",
                    appUserStats: {},
                    visibility: "private"
                },
                [`posts/doc`]: {
                    path: "",
                    ownerId: myAuthUid
                }
            }
        ,
        uid: myAuthUid,
        assert: test.assertSucceeds
    },
    {
        description: "should get public user document",
        setupData:
            {
                [`users/${otherAuthUid}`]: {
                    username: "Eltryo",
                    email: "david.merkl.dm@gmail.com",
                    appUserStats: {},
                    visibility: "public"
                },
                [`posts/doc`]: {
                    path: "",
                    ownerId: otherAuthUid
                }
            }
        ,
        uid: myAuthUid,
        assert: test.assertSucceeds
    }
]