import express from "express";
import mongoose from "mongoose";
import dotenv from "dotenv";
import router from "./router/TBLrouter.js";
import routerprof from "./router/profileRoute.js";

dotenv.config();

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Mount the routes for sweets
app.use("/api", router);
app.use("/api/read", router);
app.use("/api/create", router);
app.use("/api/edit", router);
app.use("/api/delete", router);

// profile 
app.use("/api", routerprof)
app.use("/api/create-profile",routerprof)
app.use("/api/profile/me", routerprof)
app.use("/api/login", routerprof)




// Database connection
mongoose
  .connect(process.env.MONGO_URI)
  .then(() => console.log("Database connected successfully"))
  .catch((err) => console.error("Database connection error:", err));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
