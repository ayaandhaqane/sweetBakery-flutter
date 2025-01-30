import mongoose from "mongoose";

const profileSchema = new mongoose.Schema(
  {
    name: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    username: { type: String, required: true },
    password: { type: String, required: true },
    phone: { type: String },
    address: { type: String },
  },
  {
    timestamps: true,
  }
);

const Profile = mongoose.model("UserProfile", profileSchema);

export default Profile;
