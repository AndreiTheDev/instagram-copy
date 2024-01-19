const { onCall } = require("firebase-functions/v2/https");
const { logger } = require("firebase-functions/v2");
const admin = require("firebase-admin");

exports.initUserWithData = onCall((request) => {
  logger.info("init user with data");
  logger.debug(request.data);
  const defaultFirestore = admin.firestore();
  var batch = defaultFirestore.batch();

  var userInfoDoc = defaultFirestore
    .collection("users")
    .doc(request.data.uid)
    .collection("user_info")
    .doc("data");

  batch.set(userInfoDoc, request.data.signUpData, { merge: true });

  var userProfileDoc = defaultFirestore
    .collection("users")
    .doc(request.data.uid)
    .collection("profile_info")
    .doc("data");
  batch.set(
    userProfileDoc,
    {
      description: "",
      followers: {},
      following: {},
      highlights: {},
      posts: {},
      posts_number: 0,
      profile_picture: "default_pic",
    },
    { merge: true }
  );

  var { username } = request.data.signUpData;
  logger.debug(username);
  var usernamesDoc = defaultFirestore.collection("usernames").doc(username);
  batch.set(usernamesDoc, { username: username }, { merge: true });
  batch.commit();
  return;
});

exports.checkUsernameExists = onCall((request) => {
  logger.info("check username exists");
  logger.debug(request.data);

  var usernameDoc = admin.firestore().doc(`usernames/${request.data}`).get();
  return usernameDoc.then((doc) => {
    logger.debug(doc.exists);
    if (doc.exists) {
      return false;
    }
    return true;
  });
});

exports.generateSignInToken = onCall((request) => {
  return admin
    .auth()
    .createCustomToken(request.data.uid)
    .then(
      (customToken) => {
        logger.debug(`customToken: ${customToken}`);
        return customToken;
      },
      (reason) => {
        logger.debug(`reason: ${reason}`);
        throw {
          error: Error("Token generation has been rejected"),
          errorCode: "rejected-token-error",
        };
      }
    );
});
