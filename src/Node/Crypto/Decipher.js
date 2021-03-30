"use strict";

var crypto = require('crypto');

exports._createDecipher = (algorithm, password) => () => crypto.createDecipher(algorithm, password)

exports._createDecipherIv = (algorithm, key, iv) => () => {
    console.log("crypto lib key", key)
    return crypto.createDecipheriv(algorithm, key, iv)
}

exports._update = (decipher, buffer) => () => {
    console.log("buffer", buffer);
    return decipher.update(buffer)
}

exports._setAuthTag = (decipher, tag) => () => {
    console.log("tag in lib", tag)
    return decipher.setAuthTag(tag)
}

exports.final = (decipher) => () => {
    return decipher.final()
}
