const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.checkExpiredRequests = functions.pubsub.schedule("every 24 hours")
    .onRun(async (context) => {
      const now = admin.firestore.Timestamp.now();

      try {
        const expiredRequests = await admin.firestore()
            .collection("requests")
            .where("deadline", "<=", now)
            .get();
        expiredRequests
            .forEach(async (doc) => {
              await doc.ref.update({expired: true});
              console.log(`Updated request ${doc.id} to expired.`);
            });
      } catch (error) {
        console.error("Error updating expired requests:", error);
      }

      return null;
    });
