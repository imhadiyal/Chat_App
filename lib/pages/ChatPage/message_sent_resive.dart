widget message{
  return ConstrainedBox(
constraints: BoxConstraints(
maxWidth:
MediaQuery.sizeOf(context).width * 0.7,
),
child: chat.type == 'sent'
? Container(
padding: const EdgeInsets.all(10),
margin: const EdgeInsets.only(
bottom: 5,
),
decoration: BoxDecoration(
color: Colors.white,
border: Border.all(),
borderRadius:
const BorderRadius.only(
topLeft:
Radius.circular(10),
topRight:
Radius.circular(10),
bottomLeft:
Radius.circular(10)),
),
child: Row(
mainAxisSize: MainAxisSize.min,
children: [
Text(
chat.msg,
style: const TextStyle(
fontSize: 21,
color: Colors.black,
fontWeight: FontWeight.bold,
),
),
Text(
chat.time.toString(),
style: const TextStyle(
fontSize: 10,
color: Colors.black,
fontWeight: FontWeight.bold,
),
),
Image(
image: chat.status == 'seen'
? const AssetImage(
'assets/images/seen.png',
)
    : const AssetImage(
'assets/images/unseen.png'),
fit: BoxFit.fill,
height: 30,
width: 30,
)
],
),
)
    : Container(
padding: const EdgeInsets.all(10),
margin: const EdgeInsets.only(
bottom: 5,
),
decoration: BoxDecoration(
color: Colors.white,
border: Border.all(),
borderRadius:
const BorderRadius.only(
bottomRight:
Radius.circular(10),
topRight:
Radius.circular(10),
bottomLeft:
Radius.circular(10)),
),
child: Text(
chat.msg,
),
)),
}