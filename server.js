const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv");
dotenv.config();
const db = require("./config/db");
const app = express();
app.use(cors());
app.use(express.json());


const authRoutes = require("./routes/authRoutes");
const adminRoutes = require("./routes/adminRoutes");
const ratingRoutes = require("./routes/ratingRoutes");
const userRoutes = require("./routes/userRoutes"); 
const storeRoutes = require("./routes/storeRoutes");
const ownerRoutes = require("./routes/ownerRoutes");


app.use("/api/auth", authRoutes);        
app.use("/api/admin", adminRoutes);     
app.use("/api/ratings", ratingRoutes);   
app.use("/api", userRoutes);             
app.use("/api/stores", storeRoutes);     
app.use("/api/owner", ownerRoutes);      


const PORT = process.env.PORT || 5000;
app.get("/", (req, res) => {
  res.redirect("/api/admin/users");
});

app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
});
 db.query("SELECT id, name, email, role, address FROM users", (err, results) => {
    if (err) {
      console.error("❌ Error fetching users:", err);
    } else {
      console.log("✅ All users:");
      console.table(results);
    }
  });
