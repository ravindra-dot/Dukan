const db = require("../config/db");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

// register user

exports.register = async (req,res) => {
    const {full_name, email, phone, password} = req.body;

    try{
        const hashedPassword = await bcrypt.hash(password,10);

        db.query(
            "INSERT INTO USERS (full_name, email, phone, password) VALUES (?,?,?,?)",
            [full_name,email,phone,hashedPassword],
            (err,result) => {
                if(err) return res.send(err),
                
                res.send("User registered ");
            }
        );
    }catch(err){
        res.send(err);;

    }
};

// login 
exports.login = (req, res) => {
  const { phone, password } = req.body;

  db.query(
    "SELECT * FROM Users WHERE phone = ?",
    [phone],
    async (err, result) => {
      if (err) return res.send(err);
      if (result.length === 0) return res.send("User not found");

      const user = result[0];

      const isMatch = await bcrypt.compare(password, user.password);

      if (!isMatch) return res.send("Wrong password");

      const token = jwt.sign(
        { id: user.id, phone: user.phone },
        "secretkey",
        { expiresIn: "1h" }
      );

      res.json({ message: "Login success...", token });
    }
  );
};