const v1functions = require("firebase-functions/v1");
const admin = require("firebase-admin");

admin.initializeApp();

exports.beforeCreate = v1functions.auth.user().beforeCreate((user, context) => {
  v1functions.logger.info("before create");
  var doc = admin.firestore().doc(`users/${user.uid}`).get();
  doc.then((doc) => {
    if (doc.exists) {
      return;
    }
    admin
      .firestore()
      .doc(`users/${user.uid}`)
      .set({ uid: user.uid, email: user.email }, { merge: true });
  });
  return;
});
