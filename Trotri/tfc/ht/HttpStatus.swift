/*
 * Copyright (C) 2017 The Swift Open Source Project
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
 * HttpStatus class file
 * HTTP状态码
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: HttpStatus.swift 1 2017-07-27 16:05:06Z huan.song $
 * @since 1.0
 */
class HttpStatus {
    /**
     * Continue (HTTP/1.1 - RFC 2616)
     */
    public static let SC_CONTINUE: Int = 100
    
    /**
     * Switching Protocols (HTTP/1.1 - RFC 2616)
     */
    public static let SC_SWITCHING_PROTOCOLS: Int = 101
    
    /**
     * Processing (WebDAV - RFC 2518)
     */
    public static let SC_PROCESSING: Int = 102
    
    /**
     * OK (HTTP/1.0 - RFC 1945)
     */
    public static let SC_OK: Int = 200
    
    /**
     * Created (HTTP/1.0 - RFC 1945)
     */
    public static let SC_CREATED: Int = 201
    
    /**
     * Accepted (HTTP/1.0 - RFC 1945)
     */
    public static let SC_ACCEPTED: Int = 202
    
    /**
     * Non Authoritative Information (HTTP/1.1 - RFC 2616)
     */
    public static let SC_NON_AUTHORITATIVE_INFORMATION: Int = 203
    
    /**
     * No Content (HTTP/1.0 - RFC 1945)
     */
    public static let SC_NO_CONTENT: Int = 204
    
    /**
     * Reset Content (HTTP/1.1 - RFC 2616)
     */
    public static let SC_RESET_CONTENT: Int = 205
    
    /**
     * Partial Content (HTTP/1.1 - RFC 2616)
     */
    public static let SC_PARTIAL_CONTENT: Int = 206
    
    /**
     * Multi-Status (WebDAV - RFC 2518) or 207 Partial Update OK (HTTP/1.1 - draft-ietf-http-v11-spec-rev-01?)
     */
    public static let SC_MULTI_STATUS: Int = 207
    
    /**
     * Mutliple Choices (HTTP/1.1 - RFC 2616)
     */
    public static let SC_MULTIPLE_CHOICES: Int = 300
    
    /**
     * Moved Permanently (HTTP/1.0 - RFC 1945)
     */
    public static let SC_MOVED_PERMANENTLY: Int = 301
    
    /**
     * Moved Temporarily (Sometimes Found) (HTTP/1.0 - RFC 1945)
     */
    public static let SC_MOVED_TEMPORARILY: Int = 302
    
    /**
     * See Other (HTTP/1.1 - RFC 2616)
     */
    public static let SC_SEE_OTHER: Int = 303
    
    /**
     * Not Modified (HTTP/1.0 - RFC 1945)
     */
    public static let SC_NOT_MODIFIED: Int = 304
    
    /**
     * Use Proxy (HTTP/1.1 - RFC 2616)
     */
    public static let SC_USE_PROXY: Int = 305
    
    /**
     * Temporary Redirect (HTTP/1.1 - RFC 2616)
     */
    public static let SC_TEMPORARY_REDIRECT: Int = 307
    
    /**
     * Bad Request (HTTP/1.1 - RFC 2616)
     */
    public static let SC_BAD_REQUEST: Int = 400
    
    /**
     * Unauthorized (HTTP/1.0 - RFC 1945)
     */
    public static let SC_UNAUTHORIZED: Int = 401
    
    /**
     * Payment Required (HTTP/1.1 - RFC 2616)
     */
    public static let SC_PAYMENT_REQUIRED: Int = 402
    
    /**
     * Forbidden (HTTP/1.0 - RFC 1945)
     */
    public static let SC_FORBIDDEN: Int = 403
    
    /**
     * Not Found (HTTP/1.0 - RFC 1945)
     */
    public static let SC_NOT_FOUND: Int = 404
    
    /**
     * Method Not Allowed (HTTP/1.1 - RFC 2616)
     */
    public static let SC_METHOD_NOT_ALLOWED: Int = 405
    
    /**
     * Not Acceptable (HTTP/1.1 - RFC 2616)
     */
    public static let SC_NOT_ACCEPTABLE: Int = 406
    
    /**
     * Proxy Authentication Required (HTTP/1.1 - RFC 2616)
     */
    public static let SC_PROXY_AUTHENTICATION_REQUIRED: Int = 407
    
    /**
     * Request Timeout (HTTP/1.1 - RFC 2616)
     */
    public static let SC_REQUEST_TIMEOUT: Int = 408
    
    /**
     * Conflict (HTTP/1.1 - RFC 2616)
     */
    public static let SC_CONFLICT: Int = 409
    
    /**
     * Gone (HTTP/1.1 - RFC 2616)
     */
    public static let SC_GONE: Int = 410
    
    /**
     * Length Required (HTTP/1.1 - RFC 2616)
     */
    public static let SC_LENGTH_REQUIRED: Int = 411
    
    /**
     * Precondition Failed (HTTP/1.1 - RFC 2616)
     */
    public static let SC_PRECONDITION_FAILED: Int = 412
    
    /**
     * Request Entity Too Large (HTTP/1.1 - RFC 2616)
     */
    public static let SC_REQUEST_TOO_LONG: Int = 413
    
    /**
     * Request-URI Too Long (HTTP/1.1 - RFC 2616)
     */
    public static let SC_REQUEST_URI_TOO_LONG: Int = 414
    
    /**
     * Unsupported Media Type (HTTP/1.1 - RFC 2616)
     */
    public static let SC_UNSUPPORTED_MEDIA_TYPE: Int = 415
    
    /**
     * Requested Range Not Satisfiable (HTTP/1.1 - RFC 2616)
     */
    public static let SC_REQUESTED_RANGE_NOT_SATISFIABLE: Int = 416
    
    /**
     * Expectation Failed (HTTP/1.1 - RFC 2616)
     */
    public static let SC_EXPECTATION_FAILED: Int = 417
    
    /**
     * Static constant for a 419 error.
     */
    public static let SC_INSUFFICIENT_SPACE_ON_RESOURCE: Int = 419
    
    /**
     * Static constant for a 420 error.
     */
    public static let SC_METHOD_FAILURE: Int = 420
    
    /**
     * Unprocessable Entity (WebDAV - RFC 2518)
     */
    public static let SC_UNPROCESSABLE_ENTITY: Int = 422
    
    /**
     * Locked (WebDAV - RFC 2518)
     */
    public static let SC_LOCKED: Int = 423
    
    /**
     * Failed Dependency (WebDAV - RFC 2518)
     */
    public static let SC_FAILED_DEPENDENCY: Int = 424
    
    /**
     * Server Error (HTTP/1.0 - RFC 1945)
     */
    public static let SC_INTERNAL_SERVER_ERROR: Int = 500
    
    /**
     * Not Implemented (HTTP/1.0 - RFC 1945)
     */
    public static let SC_NOT_IMPLEMENTED: Int = 501
    
    /**
     * Bad Gateway (HTTP/1.0 - RFC 1945)
     */
    public static let SC_BAD_GATEWAY: Int = 502
    
    /**
     * Service Unavailable (HTTP/1.0 - RFC 1945)
     */
    public static let SC_SERVICE_UNAVAILABLE: Int = 503
    
    /**
     * Gateway Timeout (HTTP/1.1 - RFC 2616)
     */
    public static let SC_GATEWAY_TIMEOUT: Int = 504
    
    /**
     * HTTP Version Not Supported (HTTP/1.1 - RFC 2616)
     */
    public static let SC_HTTP_VERSION_NOT_SUPPORTED: Int = 505
    
    /**
     * Insufficient Storage (WebDAV - RFC 2518)
     */
    public static let SC_INSUFFICIENT_STORAGE: Int = 507
    
}
