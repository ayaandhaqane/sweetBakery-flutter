import mongoose from "mongoose";

const createtblSchema = new mongoose.Schema({
    name: { type: String, required: true },
    description: { type: String, required: true },
    price: { type: Number, required: true },
    imageUrl: { type: String, require:true },
},{
    Timestamp:true
});

const sweets = mongoose.model('sweets', createtblSchema);

export default sweets;