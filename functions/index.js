const functions = require("firebase-functions");

// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.makeUppercase = functions.firestore.document("/messages/{documentId}")
    .onCreate((snap, context) => {
        const original = snap.data().original;
        console.log("Uppercasing", context.params.documentId, original);
        const uppercase = original.toUpperCase();
        return snap.ref.set({uppercase}, {merge: true});
    });
