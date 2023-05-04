const test = require("@firebase/rules-unit-testing");

const myAuthUid = "cVV9YzdhqTSH0vr4YI4IzhzjroH3";
const otherAuthUid = "fW6YDKz1uwhAglNhF8Lb6HKqzwm2";
const myAuth = {uid: myAuthUid, email: "david.merkl.dm@gmail.com", firebase: {sign_in_provider: "password"}};
const otherAuth = {uid: otherAuthUid, email: "max.mustermann@gmail.com", firebase: {sign_in_provider: "anonymous"}};

exports.getTests = [
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

exports.updateTests = [
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

