const functions = require("firebase-functions");

const admin = require("firebase-admin");
admin.initializeApp(functions.config());

exports.moderatorYap = functions.document('moderators/{moderator_status}').onWrite(async (docu) => {
    const oncekiModeratorDurumu = docu.before.data().moderator_status;
    const sonrakiModeratorDurumu = docu.after.data().moderator_status;
    if(oncekiModeratorDurumu !== sonrakiModeratorDurumu){
        const moderatorOnceki = await admin.auth().getUserByEmail(docu.after.data().email);
        console.log(moderatorOnceki.customClaims);
        await admin.auth().setCustomUserClaims(moderatorOnceki.uid,{
            moderator:sonrakiModeratorDurumu,
        });
        const moderatorSonraki= await admin.auth().getUserByEmail(docu.after.data().email);
        console.log(moderatorSonraki.customClaims);
    }
},
);

exports.fonksiyonIsmi = functions.https.onRequest((istek, cevap)=>{
  console.log("http isteği alındı log");

  cevap.send("Https isteği alındı send");

  functions.logger.log("Https isteğine cevap oluşturuldu functions.logger.log");
});

exports.helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", {structuredData: true});
  response.send("Hello from Firebase!");
});
