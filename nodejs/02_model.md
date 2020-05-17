### Model 

- a Mongoose model is **a wrapper on the Mongoose schema**.

### Schema

- a Mongoose schema defines the structure of the document, default values, validators, etc., whereas a Mongoose model provides an interface to the database for creating, querying, updating, deleting records, etc.

  ```js
  // example
  const mongoose = require("mongoose");
  const Schema = mongoose.Schema;
  
  const productSchema = mongoose.Schema({
    writer: {
      type: Schema.Types.ObjectId,
      ref: "User"
    },
    title: {
      type: String,
      maxlength: 50
    },
    description: {
      type: String
    }
  }, {timestamps: true})
  
  const Product = mongoose.model("Product", productSchema)
  
  module.exports = { Product }
  ```

- ```js
  // models/User.js
  const mongoose = require("mongoose");
  const userSchema = mongoose.Schema({
    name: {
      type: String,
      maxlength: 50
    },
    email: {
      typs: String,
      trim: true, // delete space
      unique: 1
    },
    password: {
      typs: String,
      minlength: 5
    },
    lastname: {
      type: String,
      maxlength: 50
    },
    role: {
      type: Number,
      default: 0
    },
    image: String,
    token: {
      type: String
    },
    tokenExp: {
      type: Number
    }
  })
  
  const User = mongoose.model('User', userSchema);
  module.exports = { User }
  ```

  