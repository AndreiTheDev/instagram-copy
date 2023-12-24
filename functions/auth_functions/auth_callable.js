const { onCall } = require('firebase-functions/v2/https');
const { logger } = require('firebase-functions/v2');
const { getFirestore } = require('firebase-admin/firestore');

exports.postsignupdetails = onCall((request) => {
    logger.info('post sign up trigger');
    logger.debug(request.data);
    return getFirestore().doc(`users/${request.data.uid}`).set(request.data.signUpData, { merge: true }).then(() => null);
});
