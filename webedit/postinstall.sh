#!/bin/bash

post_install_documentserver () {
set +x
echo DEBUG====================
	sudo cp -t /app/onlyoffice/DocumantServer/data postinstall.sh
	sudo docker exec -ti ${DOCUMENT_CONTAINER_ID} \
        sed -i /var/www/onlyoffice/documentserver/server/Common/sources/license.js \
        -e's/${PUBKEY1}/${PUBKEY2}/';
	sudo docker exec -ti ${DOCUMENT_CONTAINER_ID} \
        bash /var/www/onlyoffice/Data/postinstall.sh
echo DEBUG==================== && sleep 2
set -x
	sudo docker stop ${DOCUMENT_CONTAINER_ID};
	sudo docker start ${DOCUMENT_CONTAINER_ID};
}
PUBKEY1="MIGfMA.*IDAQAB";
PUBKEY2="MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCkDrJdg6Bv6CrwbLbOUdqLegvB\nBMXKatWKdWkL1IPszu\+FA5GsnTg5QaFU6D1qZ7yMyA5BfMpjSh08IjfEcccFNmUE\nvIPk/16gZ6FMMr7Nupb\/\+YRcJPO1EtzFl\+uUi\+Mha\//pBSZSFwHOGChfK\++KC2MFs4\nH1xqoJwNHbbtuqRMJQIDAQAB";
echo -e '-----BEGIN RSA PRIVATE KEY-----'$'\n''MIICXAIBAAKBgQCkDrJdg6Bv6CrwbLbOUdqLegvBBMXKatWKdWkL1IPszu+FA5Gs'$'\n'\
'nTg5QaFU6D1qZ7yMyA5BfMpjSh08IjfEcccFNmUEvIPk/16gZ6FMMr7Nupb/+YRc'$'\n''JPO1EtzFl+uUi+Mha/pBSZSFwHOGChfK+KC2MFs4H1xqoJwNHbbtuqRMJQIDAQAB'$'\n'\
'AoGACkxp4fjrT1sRpvoMF7OHto24wysbh3NhaEmqiHWUun7bBkyNDnroFqAKEpxp'$'\n''jo5ohaXhTzcYNVdnsmire4dw6McT7YqTORTTAyMrhlgqG30j8dSthamV0tfaH/d2'$'\n'\
'Lc/48pLxWFBNzP0UcJF22Ar/wyI4xXTet6XTf1v0szZN/AECQQDaC6+/UViSdgLP'$'\n''44zT4Kas1/9SN4SfEz82/7WhBpmB6rBUUJ5oMBQ5SKtI7Ojlkqa1ZzdZa5w2VRmz'$'\n'\
'oafj5teBAkEAwJ0+rj8jwed/drhNRDTq/VqCK6JR6neFD/L6NfutHzRk5yGH5V4j'$'\n''8F2nPKlbrMRAZC8jZLtiO0l9l2Fdi/5mpQJAQYbHjxg0JPegCreYh8f4bvMOgLe8'$'\n'\
'fE29bprUC4s/MKLF0ODVafwg58Il72l66Br1TIizQoUrUcyrR6dqG/wwgQJAE4ee'$'\n''FGLYiE+lr+7t/q1y6i9kJXJ25dQqjLxxPEoBermARaMzuUD7WeLVEySE5BaeBMp2'$'\n'\
'xz7sreA8uL2pk4k+9QJBAJbny+VKdVRPJOuzyd4Vb6Ch7Pk1XgWsUhpz7J+VygVK'$'\n''fQx6FjG0vazCG7j1rTBnoZ+pjPK2MOJHeuanbgsGIE0='$'\n''-----END RSA PRIVATE KEY-----' > Rlkcjlvkjdslkdjfflkjlksjadkjasdiuwyruwe
LICENSEDATA="{\"branding\":true,\"end_date\":\"2019-12-06T23:59:59.000Z\",\"light\":\"False\",\"portal_count\":\"4\",\"process\":2,\"test\":\"False\",\"trial\":\"False\",\"user_quota\":\"0\",\"customer_id\":\"010101010101\",\"start_date\":\"2018-12-06T00:00:00.000Z\",\"plugins\":\"true\",\"users_count\":150,\"mode\":0,\"version\":3}"
SIGNDATA="var Rlkcjlvkjdslkdjfflkjaskdjaklsdjalksjakjasdiuwyruwerwwmfn = require('crypto');
var Gljdfgkljfkgjdlfjgdlfjgldkfjgkdhgsfhshsdgfjdgsfjdgfjdshfjkdshfjkdskhf = require('fs');
var Rlkcjlvkjdslkdjfflkjlksjadkjasdiuwyruwerwwmfnmrn = Gljdfgkljfkgjdlfjgdlfjgldkfjgkdhgsfhshsdgfjdgsfjdgfjdshfjkdshfjkdskhf.readFileSync('Rlkcjlvkjdslkdjfflkjlksjadkjasdiuwyruwe').toString();
var Rlkcjlvkjdslkdjfflkjlksjadkjasdiuwyruwerwwmfn = Gljdfgkljfkgjdlfjgdlfjgldkfjgkdhgsfhshsdgfjdgsfjdgfjdshfjkdshfjkdskhf.readFileSync('R1l1kcjlvkjdslkdjfflkjlksjadkjasdiuwyruwerww').toString();
Rlkcjlvkjdslkdjfflkjlksjakjasdiuwyruwerwwmfn = JSON.parse(Rlkcjlvkjdslkdjfflkjlksjadkjasdiuwyruwerwwmfn);
Rlkcjlvkjdslkdjfflkjlksjadkjasdiuwyruwerwwmfn = JSON.stringify(Rlkcjlvkjdslkdjfflkjlksjakjasdiuwyruwerwwmfn);
var Rlkcjlvkjdslkdjfflkjlksjakjasdiuwyruwalalksksjdlakjdaerwwmfn = Rlkcjlvkjdslkdjfflkjaskdjaklsdjalksjakjasdiuwyruwerwwmfn.createSign('RSA-SHA1');
Rlkcjlvkjdslkdjfflkjlksjakjasdiuwyruwalalksksjdlakjdaerwwmfn.update(Rlkcjlvkjdslkdjfflkjlksjadkjasdiuwyruwerwwmfn);
Rlkcjlvkjdslkdjfflkjlksjakjasdiuwyruwalalksksjdlakjdaerw1mfn = Rlkcjlvkjdslkdjfflkjlksjakjasdiuwyruwalalksksjdlakjdaerwwmfn.sign(Rlkcjlvkjdslkdjfflkjlksjadkjasdiuwyruwerwwmfnmrn, 'hex');
Rlkcjlvkjdslkdjfflkjlksjakjasdiuwyruwerwwmfn.signature = Rlkcjlvkjdslkdjfflkjlksjakjasdiuwyruwalalksksjdlakjdaerw1mfn;
Rlkcjlvkjdslkdjfflkjlksjadkjasdiuwyruwerwwmfn = JSON.stringify(Rlkcjlvkjdslkdjfflkjlksjakjasdiuwyruwerwwmfn);
Gljdfgkljfkgjdlfjgdlfjgldkfjgkdhgsfhshsdgfjdgsfjdgfjdshfjkdshfjkdskhf.writeFileSync('license.lic', Rlkcjlvkjdslkdjfflkjlksjadkjasdiuwyruwerwwmfn);
console.log(Rlkcjlvkjdslkdjfflkjlksjadkjasdiuwyruwerwwmfn);"
echo $LICENSEDATA > R1l1kcjlvkjdslkdjfflkjlksjadkjasdiuwyruwerww
echo $SIGNDATA > Gljdfgkljfkgjdlfjgdlfjgldkfjgkdhgsfhshsdg
node Gljdfgkljfkgjdlfjgdlfjgldkfjgkdhgsfhshsdg
post_install_documentserver
rm -f Gljdfgkljfkgjdlfjgdlfjgldkfjgkdhgsfhshsdg R1l1kcjlvkjdslkdjfflkjlksjadkjasdiuwyruwerww Rlkcjlvkjdslkdjfflkjlksjadkjasdiuwyruwe
exit 0
