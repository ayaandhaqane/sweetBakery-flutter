import express from "express";
import sweets from "../modalSchema/TBLSchema.js";
import data from "../data.js";

const router = express.Router();


 router.get('/', async(req, res) => {
   await sweets.removeAllListeners()
   
const xog = await sweets.insertMany(data.sweet)
res.send({xog});
});


// Create a new item
router.post("/create", async (req, res) => {
  try {
    const { name, description, price, imageUrl } = req.body;

    const newSweet = new sweets({
      name,
      description,
      price,
      imageUrl,
    });

    const savedSweet = await newSweet.save();
    res.status(201).json(savedSweet);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get all items
router.get("/read", async (req, res) => {
  try {
    const allSweets = await sweets.find();
    res.status(200).json(allSweets);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get a specific item by ID
router.get("/read/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const sweet = await sweets.findById(id);
    if (!sweet) {
      return res.status(404).json({ message: "Item not found" });
    }
    res.status(200).json(sweet);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Update an item by ID
router.put("/edit/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const { name, description, price, imageUrl } = req.body;

    const updatedSweet = await sweets.findByIdAndUpdate(
      id,
      { name, description, price, imageUrl },
      { new: true }
    );

    if (!updatedSweet) {
      return res.status(404).json({ message: "Item not found" });
    }

    res.status(200).json(updatedSweet);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Delete an item by ID
router.delete("/delete/:id", async (req, res) => {
  try {
    const { id } = req.params;

    const deletedSweet = await sweets.findByIdAndDelete(id);

    if (!deletedSweet) {
      return res.status(404).json({ message: "Item not found" });
    }

    res.status(200).json({ message: "Item deleted successfully" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

export default router;








































































































































































































