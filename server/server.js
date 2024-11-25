const express = require('express');
const bodyParser = require('body-parser');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const cors = require('cors');
const nodemailer = require('nodemailer');  // 引入 nodemailer
const crypto = require('crypto');  // 用于生成验证码

const app = express();
const port = 3000;

app.use(cors());
app.use(bodyParser.json());

// 模拟数据库
const mockUserData = {};
const verificationCodes = {};  // 存储验证码

// 邮箱配置
const transporter = nodemailer.createTransport({
    service: '126', // 使用 126 邮箱
    auth: {
        user: 'tlk_sure@126.com',  // 发件人邮箱
        pass: 'TJhzZdbL4BkNXJtN',  // 授权码
    },
});

// 发送验证码接口
app.post('/send-verification-code', async (req, res) => {
    const { email } = req.body;

    // 生成验证码
    const verificationCode = crypto.randomInt(100000, 999999).toString();
    verificationCodes[email] = { code: verificationCode, expires: Date.now() + 300000 };

    try {
        // 发送验证码
        await transporter.sendMail({
            from: 'tlk_sure@126.com',
            to: email,
            subject: '验证码',
            text: `【星语小屋】您的验证码是: ${verificationCode}，验证码5分中内有效。`,
        });

        // 成功返回响应
        return res.json({ message: '验证码发送成功' });
    } catch (error) {
        console.error('邮件发送失败:', error);
        return res.status(500).json({ message: '验证码发送失败' });
    }
});


// 验证验证码接口
// 验证验证码接口
app.post('/verify-code', (req, res) => {
    const { email, code } = req.body;

    // 检查验证码是否存在且是否过期
    if (!verificationCodes[email]) {
        return res.status(400).json({ message: '验证码不存在' });
    }

    const { code: storedCode, expires } = verificationCodes[email];

    // 检查验证码是否过期
    if (Date.now() > expires) {
        delete verificationCodes[email];  // 清除过期的验证码
        return res.status(400).json({ message: '验证码已过期' });
    }

    // 验证输入的验证码是否正确
    if (storedCode === code) {
        return res.json({ message: '验证码验证成功' });
    } else {
        return res.status(400).json({ message: '验证码错误' });
    }
});


// 注册接口
app.post('/register', async (req, res) => {
    const { username, password } = req.body;

    if (mockUserData[username]) {
        return res.json({
            message: '用户名已存在',
        });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    mockUserData[username] = { username, password: hashedPassword };

    return res.json({
        message: '注册成功',
    });
});

// 登录接口
app.post('/login', async (req, res) => {
    const { username, password } = req.body;

    const user = mockUserData[username];
    if (!user) {
        return res.json({
            message: '用户不存在',
        });
    }

    const passwordMatch = await bcrypt.compare(password, user.password);
    if (!passwordMatch) {
        return res.json({
            message: '密码错误',
        });
    }

    const token = jwt.sign({ username }, 'your_jwt_secret', { expiresIn: '1h' });

    return res.json({
        message: '登录成功',
        token,
    });
});

app.listen(port, () => {
    console.log(`服务器已启动，监听端口 ${port}`);
});
