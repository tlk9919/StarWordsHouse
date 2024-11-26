const express = require('express');
const bodyParser = require('body-parser');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const cors = require('cors');
const nodemailer = require('nodemailer');
const crypto = require('crypto');
const mongoose = require('mongoose');

const app = express();
const port = 3000;

// 连接到 MongoDB 数据库

mongoose.connect('mongodb://localhost:27017/starwisper')
    .then(() => console.log('MongoDB 连接成功'))
    .catch((err) => console.error('MongoDB 连接失败', err))


// 用户模型
const UserSchema = new mongoose.Schema({
    username: { type: String, required: true, unique: true },
    password: { type: String, required: true },
});
const User = mongoose.model('User', UserSchema);

// 验证码模型
const VerificationCodeSchema = new mongoose.Schema({
    email: { type: String, required: true, unique: true },
    code: { type: String, required: true },
    expires: { type: Date, required: true },
});
const VerificationCode = mongoose.model('VerificationCode', VerificationCodeSchema);

app.use(cors());
app.use(bodyParser.json());

// 邮箱配置
const transporter = nodemailer.createTransport({
    service: '126',
    auth: {
        user: 'tlk_sure@126.com',
        pass: 'TJhzZdbL4BkNXJtN',
    },
});

// 发送验证码接口
app.post('/send-verification-code', async (req, res) => {
    const { email } = req.body;

    // 生成验证码
    const verificationCode = crypto.randomInt(100000, 999999).toString();
    const expires = Date.now() + 300000; // 5分钟过期时间

    try {
        // 查找是否已有该邮箱的验证码
        let existingCode = await VerificationCode.findOne({ email });
        if (existingCode) {
            // 如果验证码已存在，更新它
            existingCode.code = verificationCode;
            existingCode.expires = expires;
            await existingCode.save();
        } else {
            // 如果验证码不存在，创建新验证码
            const newCode = new VerificationCode({ email, code: verificationCode, expires });
            await newCode.save();
        }

        // 发送验证码邮件
        await transporter.sendMail({
            from: 'tlk_sure@126.com',
            to: email,
            subject: '星语小屋',
            text: `【星语小屋】您的验证码是: ${verificationCode}，验证码5分钟内有效。`,
        });

        return res.json({ message: '验证码发送成功' });
    } catch (error) {
        console.error('邮件发送失败:', error);
        return res.status(500).json({ message: '验证码发送失败' });
    }
});

// 验证验证码接口
app.post('/verify-code', async (req, res) => {
    const { email, code } = req.body;

    try {
        const verificationRecord = await VerificationCode.findOne({ email });

        if (!verificationRecord) {
            return res.status(400).json({ message: '验证码不存在' });
        }

        // 检查验证码是否过期
        if (Date.now() > verificationRecord.expires) {
            await VerificationCode.deleteOne({ email });
            return res.status(400).json({ message: '验证码已过期' });
        }

        if (verificationRecord.code === code) {
            return res.json({ message: '验证码验证成功' });
        } else {
            return res.status(400).json({ message: '验证码错误' });
        }
    } catch (error) {
        console.error('验证验证码时出错:', error);
        return res.status(500).json({ message: '验证验证码时出错' });
    }
});

// 注册接口
app.post('/register', async (req, res) => {
    const { username, password } = req.body;

    try {
        // 检查用户名是否已存在
        const existingUser = await User.findOne({ username });
        if (existingUser) {
            return res.json({ message: '用户名已存在' });
        }

        // 密码加密
        const hashedPassword = await bcrypt.hash(password, 10);
        const newUser = new User({ username, password: hashedPassword });

        await newUser.save();
        return res.json({ message: '注册成功' });
    } catch (error) {
        console.error('注册时出错:', error);
        return res.status(500).json({ message: '注册失败' });
    }
});

// 登录接口
app.post('/login', async (req, res) => {
    const { username, password } = req.body;

    try {
        const user = await User.findOne({ username });
        if (!user) {
            return res.json({ message: '用户不存在' });
        }

        // 检查密码是否正确
        const passwordMatch = await bcrypt.compare(password, user.password);
        if (!passwordMatch) {
            return res.json({ message: '密码错误' });
        }

        const token = jwt.sign({ username }, 'your_jwt_secret', { expiresIn: '1h' });
        return res.json({ message: '登录成功', token });
    } catch (error) {
        console.error('登录时出错:', error);
        return res.status(500).json({ message: '登录失败' });
    }
});

app.listen(port, () => {
    console.log(`服务器已启动，监听端口 ${port}`);
});
