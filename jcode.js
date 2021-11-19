// 京东口令
// [rule: raw [\s\S]*[#|@|$|%|¥]([0-9a-zA-Z]{14})[#|@|$|%|¥][\s\S]*]
var jcode = param(1);

function main() {
    var exist = bucketGet("jcode", jcode)
    if (exist) {
        sendText(exist)
        return
    }
    for (var i = 0; i < 10; i++) {
        var data = request({
            method: "get",
            url: "https://service-crgecqni-1251133039.gz.apigw.tencentcs.com/release/code?code=(" + jcode + ")",
            dataType: "json",
        });
        if (data) {
            var replyMsg = "请检查你的口令是否正确。";
            if (data.code == 0) {
                replyMsg =
                    "活动标题：" +
                    data.data.title +
                    "\n用户昵称：" +
                    data.data.userName[0] +
                    "****\n活动链接：" +
                    data.data.jumpUrl;
            }
            sendText(replyMsg)
            bucketSet("jcode", jcode, replyMsg)
            break
        }
    }
}

main()
