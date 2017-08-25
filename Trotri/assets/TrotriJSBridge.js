/*
 * Copyright (C) 2015 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * Java Script Bridge Object
 */
var TrotriJSBridge = {};

/**
 * 系统类型
 */
TrotriJSBridge.OS = {
    /**
     * 安卓系统
     */
    TYPE_ANDROID: 1,

    /**
     * iOS系统-Swift
     */
    TYPE_IOS: 2,

    /**
     * 未知系统
     */
    TYPE_UNDEFINED: 0,

    /**
     * 系统类型
     */
    type: 0,

    /**
     * 获取系统类型，0：未知、1：Android、2：iOS-Swift
     */
    getType: function() {
        if (TrotriJSBridge.OS.type == TrotriJSBridge.OS.TYPE_UNDEFINED) {
            var userAgent = TrotriJSBridge.OS.getUserAgent();
            if (userAgent.indexOf("Android") > -1) {
                TrotriJSBridge.OS.type = TrotriJSBridge.OS.TYPE_ANDROID;
            } else if (userAgent.indexOf("Apple") > -1) {
                TrotriJSBridge.OS.type = TrotriJSBridge.OS.TYPE_IOS;
            } else {
                // 其他手机型号
            }
        }

        return TrotriJSBridge.OS.type;
    },

    /**
     * 获取是否是安卓系统
     */
    isAndroid: function() {
        return TrotriJSBridge.OS.getType() == TrotriJSBridge.OS.TYPE_ANDROID;
    },

    /**
     * 获取是否是iOS系统，只适用Swift
     */
    isIOS: function() {
        return TrotriJSBridge.OS.getType() == TrotriJSBridge.OS.TYPE_IOS;
    },

    /**
     * 获取浏览器用户代理信息
     */
    getUserAgent: function() {
        return navigator.userAgent;
    }

};

/**
 * 回调函数管理
 */
TrotriJSBridge.Listeners = {
    /**
     * 寄存回调函数的Key长度
     */
    KEY_LEN: 8,

    /**
     * 寄存回调函数的仓库
     */
    data: [],

    /**
     * 获取回调函数
     */
    get: function(key) {
        if (TrotriJSBridge.Listeners.has(key)) {
            return TrotriJSBridge.Listeners.data[key];
        }

        return null;
    },

    /**
     * 添加回调函数
     */
    add: function(key, value) {
        TrotriJSBridge.Listeners.data[key] = value;
    },

    /**
     * 删除回调函数
     */
    remove: function(key) {
        delete TrotriJSBridge.Listeners.data[key];
    },

    /**
     * 获取回调函数是否存在
     */
    has: function(key) {
        return (TrotriJSBridge.Listeners.data[key] != undefined);
    },

    /**
     * 获取寄存回调函数的Key
     */
    getKey: function() {
        var result = "";

        do {
            result = TrotriJSBridge.Listeners.randStr(TrotriJSBridge.Listeners.KEY_LEN);
        }
        while (TrotriJSBridge.Listeners.has(result));

        return result;
    },

    /**
     * 获取指定长度的随机字符串
     */
    randStr: function(len) {
        var result = "";

        if ((len = parseInt(len)) <= 0) {
            return result;
        }

        var chars = "abcdefghijklmnopqrstuvwxyz";
        for (var i = 0; i < len; i++) {
            result += chars.charAt(Math.floor(Math.random() * chars.length));
        }

        return result;
    }

};

/**
 * 日志处理
 */
TrotriJSBridge.Log = {
    /**
     * 成功码
     */
    SUCCESS_NO: 0,

    /**
     * 错误码，window.Trotri undefined, window.webkit.messageHandlers.Trotri undefined 只适用Android和iOS-Swift
     * 其他系统错误，具体看错误消息
     */
    ERRNO_SYSTEM_ERROR: -1,

    /**
     * 错误码，operating system type undefined
     */
    ERRNO_OS_UNDEFINED: -2,

    /**
     * 错误码，Native exception Js method not found
     */
    ERRNO_METHOD_NOT_FOUND: -3,

    /**
     * 错误码，Native exception Js parameter json syntax wrong
     */
    ERRNO_JSON_SYNTAX_: -4,

    /**
     * 抛出错误
     * listener = { error: function(throwable) {} }
     * throwable = { errNo: 0, errMsg: "" }
     */
    throwError: function(listener, throwable) {
        if (listener == null || typeof(listener) != "object" || listener.error == undefined) {
            alert(JSON.stringify(throwable));
        } else {
            listener.error(throwable);
        }
    }

};

/**
 * 向Native发送请求
 * parameter = { beforeAsync: function(data) {}, success: function(data) {}, error: function(data) {}, complete: function(result) {} }
 * 请求Native成功时，回调success函数，否则回调error函数，无论成功失败，都会回调complete函数，result = true | false
 *
 * 安卓系统没有window.Trotri对象时，抛出错误 = { errNo: TrotriJSBridge.Log.ERRNO_SYSTEM_ERROR, errMsg: "window.Trotri undefined" }
 * iOS-Swift系统没有window.webkit.messageHandlers.Trotri对象时，抛出错误 = { errNo: TrotriJSBridge.Log.ERRNO_SYSTEM_ERROR, errMsg: "window.webkit.messageHandlers.Trotri undefined" }
 * 系统类型未知时，抛出错误 = { errNo: TrotriJSBridge.Log.ERRNO_OS_UNDEFINED, errMsg: "operating system type undefined" }
 */
TrotriJSBridge.invoke = function(method, parameter) {
    // 只适用安卓系统
    if (TrotriJSBridge.OS.isAndroid() && !window.Trotri) {
        TrotriJSBridge.Log.throwError(parameter, {errNo: TrotriJSBridge.Log.ERRNO_SYSTEM_ERROR, errMsg: "window.Trotri undefined"});
        return;
    }

    // 只适用iOS系统-Swift
    if (TrotriJSBridge.OS.isIOS() && !window.webkit.messageHandlers.Trotri) {
        TrotriJSBridge.Log.throwError(parameter, {errNo: TrotriJSBridge.Log.ERRNO_SYSTEM_ERROR, errMsg: "window.webkit.messageHandlers.Trotri undefined"});
        return;
    }

    if (parameter == null) {
        parameter = {};
    }

    var key = TrotriJSBridge.Listeners.getKey();
    TrotriJSBridge.Listeners.add(key, parameter);

    parameter = JSON.stringify(parameter);
    var type = TrotriJSBridge.OS.getType();
    switch (type) {
        case TrotriJSBridge.OS.TYPE_ANDROID:
            Trotri.invoke(key, method, parameter);
            break;
        case TrotriJSBridge.OS.TYPE_IOS:
            window.webkit.messageHandlers.Trotri.postMessage({key: key, method: method, parameter: parameter}); // Swift
            // document.location = "Trotri://invoke?" + encodeURIComponent(key) + "&" + encodeURIComponent(method) + "&" + encodeURIComponent(parameter); // OC
            break;
        default:
            TrotriJSBridge.Log.throwError(listener, {errNo: TrotriJSBridge.Log.ERRNO_OS_UNDEFINED, errMsg: "operating system type undefined"});
            break;
    }

};

/**
 * 监听Native回调
 * throwable.errNo == TrotriJSBridge.Log.SUCCESS_NO时，回调success函数，否则回调error函数
 * 无论成功失败，都会回调complete函数，result = true | false
 */
TrotriJSBridge.onListen = function(key, data, throwable) {
    var listener = TrotriJSBridge.Listeners.get(key);
    TrotriJSBridge.Listeners.remove(key);

    if (typeof(listener) != "object") {
        TrotriJSBridge.Log.throwError(listener, throwable);
        return;
    }

    if (throwable.errNo != TrotriJSBridge.Log.SUCCESS_NO) {
        TrotriJSBridge.Log.throwError(listener, throwable);

        if (listener.complete != undefined && listener.complete != null) {
            listener.complete(false);
        }

        return;
    }

    if (listener.success != undefined && listener.success != null) {
        if (data == "" || data == undefined || data == null) {
            listener.success();
        } else {
            listener.success(data);
        }
    }

    if (listener.complete != undefined && listener.complete != null) {
        listener.complete(true);
    }

};

/**
 * 监听Native异步处理前的回调
 */
TrotriJSBridge.onBeforeAsyncListen = function(key, data) {
    var listener = TrotriJSBridge.Listeners.get(key);
    TrotriJSBridge.Listeners.remove(key);

    if (typeof(listener) != "object" || listener.beforeAsync == undefined || listener.beforeAsync == null) {
        return;
    }

    if (data == "" || data == undefined || data == null) {
        listener.beforeAsync();
    } else {
        listener.beforeAsync(data);
    }

};

/**
 * tt Object
 */
var tt = {
    /**
     * 提示
     */
    toast: function(p) {
        TrotriJSBridge.invoke("toast", {
            text: p.text, // 提示内容
            isLong: (p.isLong == undefined) ? false : (p.isLong ? true : false), // 展示时间
            success: p.success,
            error: p.error,
            complete: p.complete
        });
    },

    /**
     * 获取版本信息
     */
    getVersion: function(p) {
        TrotriJSBridge.invoke("getVersion", {
            success: p.success, // data = { code: 版本号, name: 版本名 }
            error: p.error,
            complete: p.complete
        });
    }

};
