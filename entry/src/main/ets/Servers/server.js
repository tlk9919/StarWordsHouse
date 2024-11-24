const express = require('express');
const app = express();
const { users } = require('./db');

app.use(express.urlencoded({ extended: true }));
app.use(express.json())

// 注册账号
app.post("/publish", async (req, res) => {
    try {
        const { zhanghao, mima } = req.body;
        await users.create({
            zhanghao, mima
        });
        res.send("success")
    } catch (error) {
        res.send(error, "error")
    }
})
// 注销账号
app.post("/del", async (req, res) => {
    console.log(req.body.zhanghao)
    try {
        const { zhanghao } = req.body;

        // 使用 deleteOne 删除指定 name 的数据
        const result = await users.deleteOne({ zhanghao });

        if (result.deletedCount === 1) {
            res.send("success");
        } else {
            res.send("未找到匹配的记录");
        }
    } catch (error) {
        res.send(error, "error");
    }
})
// 修改账号密码
app.post("/upd", async (req, res) => {
    try {
        const { zhanghao, newmima } = req.body;
        // 使用 updateOne 更新指定 name 的数据记录的 nianling 字段
        const result = await users.updateOne({ zhanghao }, { $set: { mima: newmima } });
        res.json({ message: "密码更新成功！", result });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 账号登录
app.get("/find/:zhanghao/:mima", async (req, res) => {
    try {
        const zhanghao = req.params.zhanghao;
        const mima = req.params.mima;

        // 使用 find 查询所有匹配指定 name 的数据记录
        const results = await users.find({ zhanghao, mima });

        if (results.length > 0) {
            // 如果找到匹配的记录，则返回所有匹配的记录
            res.json({ data: results, message: "登录成功！" });
        } else {
            res.status(404).json({ message: "未找到匹配的记录" });
        }
    } catch (error) {
        res.status(500).json({ message: "服务器内部错误" });
    }
});


app.listen(3000, () => {
    console.log('server running')
})