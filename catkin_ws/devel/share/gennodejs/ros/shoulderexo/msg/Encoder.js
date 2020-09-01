// Auto-generated. Do not edit!

// (in-package shoulderexo.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class Encoder {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.encoder1 = null;
      this.encoder2 = null;
      this.port_num = null;
    }
    else {
      if (initObj.hasOwnProperty('encoder1')) {
        this.encoder1 = initObj.encoder1
      }
      else {
        this.encoder1 = 0.0;
      }
      if (initObj.hasOwnProperty('encoder2')) {
        this.encoder2 = initObj.encoder2
      }
      else {
        this.encoder2 = 0.0;
      }
      if (initObj.hasOwnProperty('port_num')) {
        this.port_num = initObj.port_num
      }
      else {
        this.port_num = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Encoder
    // Serialize message field [encoder1]
    bufferOffset = _serializer.float32(obj.encoder1, buffer, bufferOffset);
    // Serialize message field [encoder2]
    bufferOffset = _serializer.float32(obj.encoder2, buffer, bufferOffset);
    // Serialize message field [port_num]
    bufferOffset = _serializer.int32(obj.port_num, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Encoder
    let len;
    let data = new Encoder(null);
    // Deserialize message field [encoder1]
    data.encoder1 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [encoder2]
    data.encoder2 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [port_num]
    data.port_num = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'shoulderexo/Encoder';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '87b6536489d17685402d604f766db88a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 encoder1
    float32 encoder2
    int32 port_num
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Encoder(null);
    if (msg.encoder1 !== undefined) {
      resolved.encoder1 = msg.encoder1;
    }
    else {
      resolved.encoder1 = 0.0
    }

    if (msg.encoder2 !== undefined) {
      resolved.encoder2 = msg.encoder2;
    }
    else {
      resolved.encoder2 = 0.0
    }

    if (msg.port_num !== undefined) {
      resolved.port_num = msg.port_num;
    }
    else {
      resolved.port_num = 0
    }

    return resolved;
    }
};

module.exports = Encoder;
