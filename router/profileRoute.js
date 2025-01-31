import express from "express";
import Profile from "../modalSchema/profileSchmea.js";
import jwt from "jsonwebtoken";
import multer from 'multer';

const router = express.Router();

// Middleware: Authenticate Token
const authenticateToken = (req, res, next) => {
  const token = req.header("Authorization")?.split(" ")[1]; // Extract token from "Bearer <token>"
  if (!token) return res.status(401).json({ message: "Access Denied" });

  try {
    const verified = jwt.verify(token, process.env.JWT_SECRET_KEY);
    req.user = verified; // Add user info (decoded JWT) to the request object
    next();
  } catch (err) {
    res.status(403).json({ message: "Invalid Token" });
  }
};

// Get all profiles
router.get("/profiles", async (req, res) => {
  try {
    const profiles = await Profile.find(); // Fetch all users from the database
    res.status(200).json(profiles); // Return all users as JSON
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});


// Create a new profile
router.post("/create-profile", async (req, res) => {
  try {
    const profile = new Profile(req.body);
    const savedProfile = await profile.save();
    res.status(201).json(savedProfile);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});



// Login Endpoint in profileRoute.js
router.post("/login", async (req, res) => {
  const { email, password } = req.body;
  try {
    const user = await Profile.findOne({ email });
    if (!user || user.password !== password) {
      return res.status(401).json({ message: "Invalid email or password" });
    }

    // Generate JWT
    const token = jwt.sign({ email: user.email }, process.env.JWT_SECRET_KEY, {
      expiresIn: "1h",
    });

    res.status(200).json({ token, user });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});


// Get logged-in user's profile
router.get("/profile/me", authenticateToken, async (req, res) => {
  try {
    const email = req.user.email; // Decoded from JWT
    const profile = await Profile.findOne({ email });

    if (!profile) {
      return res.status(404).json({ message: "Profile not found" });
    }

    res.status(200).json(profile);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Update a profile
router.put("/profile/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const updatedProfile = await Profile.findByIdAndUpdate(id, req.body, {
      new: true,
    });
    if (!updatedProfile) {
      return res.status(404).json({ message: "Profile not found" });
    }
    res.status(200).json(updatedProfile);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Delete a profile
router.delete("/profile/delete", async (req, res) => {
  try {
    const { id } = req.params;
    const deletedProfile = await Profile.findByIdAndDelete(id);
    if (!deletedProfile) {
      return res.status(404).json({ message: "Profile not found" });
    }
    res.status(200).json({ message: "Profile deleted successfully" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});







// Multer configuration for file uploads
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "uploads/"); // Directory to store uploaded files
  },
  filename: function (req, file, cb) {
    cb(null, `${Date.now()}-${file.originalname}`); // Unique file name
  },
});

const upload = multer({ storage });

// Upload image endpoint
router.post("/upload-image", authenticateToken, upload.single("image"), async (req, res) => {
  try {
    const userId = req.user.id; // Assuming user ID is stored in the JWT
    const imagePath = `/uploads/${req.file.filename}`; // Path to the uploaded file

    // Update user profile with the new image URL
    await User.findByIdAndUpdate(userId, { imageUrl: imagePath });

    res.status(200).json({ message: "Image uploaded successfully", imageUrl: imagePath });
  } catch (error) {
    res.status(500).json({ message: "Error uploading image", error: error.message });
  }
});

export default router;
