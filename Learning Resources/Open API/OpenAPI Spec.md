# OpenAPI Specification Checklist

Use this checklist when adding, modifying, or reviewing endpoints in an OpenAPI 3.x specification.

---

## 1. Specification Metadata

### OpenAPI Version

* [ ] The document declares a supported OpenAPI version.
* [ ] The version matches the tooling used for validation and client generation.

```yaml
openapi: 3.0.3
```

or:

```yaml
openapi: 3.1.0
```

* [ ] OpenAPI 3.0 and OpenAPI 3.1 syntax are not mixed unintentionally.
* [ ] JSON Schema features unsupported by the selected OpenAPI version are avoided.

### API Information

* [ ] `info.title` clearly identifies the API.
* [ ] `info.description` explains the API's purpose.
* [ ] `info.version` reflects the API specification version.
* [ ] Contact information is included where required.
* [ ] License information is included where required.

```yaml
info:
  title: Client Service API
  description: APIs for managing client information.
  version: 1.0.0
  contact:
    name: API Support Team
    email: api-support@example.com
```

### Server Definitions

* [ ] The `servers` section is defined.
* [ ] Development, test, staging, and production URLs are correctly configured.
* [ ] Server URLs do not contain hard-coded local machine addresses.
* [ ] Server variables are used where appropriate.
* [ ] Trailing slash usage is consistent.

```yaml
servers:
  - url: https://api.example.com
    description: Production server
  - url: https://staging-api.example.com
    description: Staging server
```

---

## 2. API Path Design

### Service and Version Format

* [ ] The route follows the established service and version convention.

Example:

```text
/client/v1/clients
/client/v1/clients/{client-id}
```

* [ ] The service name is included where required.
* [ ] The API version is explicitly included.
* [ ] The version format is consistent across all endpoints.
* [ ] Existing versioned routes are not changed unintentionally.

### Path Naming

* [ ] Path segments use lowercase kebab-case.
* [ ] Words are separated using hyphens.
* [ ] Underscores are not used in paths.
* [ ] PascalCase and camelCase are not used in paths.
* [ ] Paths describe resources rather than implementation details.
* [ ] Paths do not contain unnecessary verbs.

Preferred:

```text
/client/v1/client-contacts
/client/v1/client-contacts/{contact-id}
```

Avoid:

```text
/client/v1/GetClientContacts
/client/v1/client_contacts
/client/v1/deleteClientContact
```

### Resource Naming

* [ ] Collection resources use plural nouns.
* [ ] Single-resource routes use a resource identifier.
* [ ] Subresources are used only when there is a meaningful parent-child relationship.
* [ ] Nested resource paths are not unnecessarily deep.
* [ ] The route does not expose database table names or internal class names.

Example:

```text
/client/v1/clients/{client-id}/contacts
```

### Route Consistency

* [ ] The new route follows the same naming pattern as existing routes.
* [ ] Identifier names are consistent across related routes.
* [ ] The same resource is not referred to using different names.
* [ ] Route casing is consistent.
* [ ] Filtering and sorting are represented as query parameters.

---

## 3. HTTP Method Selection

* [ ] The HTTP method matches the operation's behavior.
* [ ] The operation follows REST semantics.
* [ ] The operation does not use `POST` when a more appropriate method exists.

### GET

* [ ] `GET` is used for retrieving data.
* [ ] `GET` does not create, update, or delete resources.
* [ ] `GET` operations do not require request bodies.
* [ ] `GET` operations are safe and idempotent.

### POST

* [ ] `POST` is used to create a resource or trigger a non-idempotent operation.
* [ ] Resource creation returns `201 Created` where applicable.
* [ ] Repeated requests may create separate results unless idempotency is explicitly supported.

### PUT

* [ ] `PUT` is used for complete replacement of a resource.
* [ ] The request body represents the complete replaceable state.
* [ ] The operation is idempotent.
* [ ] Required fields for replacement are clearly documented.

### PATCH

* [ ] `PATCH` is used for partial updates.
* [ ] Only editable fields are included in the request schema.
* [ ] Patch behavior is clearly described.
* [ ] The operation documents whether omitted fields remain unchanged.
* [ ] The specification states whether JSON Merge Patch or JSON Patch is used, when applicable.
* [ ] The operation is designed to be idempotent where possible.

### DELETE

* [ ] `DELETE` is used for deleting or deactivating a resource.
* [ ] The description clearly states whether deletion is soft or permanent.
* [ ] Successful deletion returns `204 No Content` when no response body is required.
* [ ] Repeated deletion behavior is documented.

---

## 4. Tags

* [ ] Every operation includes at least one meaningful tag.
* [ ] Tags group endpoints by business capability or resource.
* [ ] Tag names are consistent across related endpoints.
* [ ] Tags are declared in the top-level `tags` section.
* [ ] Every top-level tag has a useful description.
* [ ] Unused tags are removed.

```yaml
tags:
  - name: Clients
    description: Operations for managing clients.
```

```yaml
paths:
  /client/v1/clients:
    get:
      tags:
        - Clients
```

---

## 5. Operation Metadata

### Summary

* [ ] Every operation includes a `summary`.
* [ ] The summary is short and action-oriented.
* [ ] The summary clearly identifies the operation.
* [ ] The summary does not simply repeat the route.

```yaml
summary: Retrieve clients
```

### Description

* [ ] Every operation includes a clear `description`.
* [ ] The description explains the business behavior.
* [ ] Preconditions are documented.
* [ ] Authorization expectations are documented where relevant.
* [ ] Side effects are documented.
* [ ] Soft-delete, archival, or state-transition behavior is documented.
* [ ] Important validation rules are documented.
* [ ] The description does not expose unnecessary internal implementation details.

### Operation ID

* [ ] Every operation has an `operationId`.
* [ ] Every `operationId` is globally unique.
* [ ] The naming format is consistent.
* [ ] The value is suitable for generated client method names.
* [ ] The value does not contain spaces or special characters.
* [ ] The value does not include redundant service prefixes unless required.

Recommended format:

```yaml
operationId: getClients
operationId: getClientById
operationId: createClient
operationId: updateClient
operationId: deleteClient
```

---

## 6. Parameter Validation

### General Parameter Rules

* [ ] All operation parameters are declared.
* [ ] Parameters are declared in either the path-level or operation-level `parameters` section.
* [ ] Duplicate parameter declarations are avoided.
* [ ] Parameter names are meaningful and consistent.
* [ ] Each parameter includes a description.
* [ ] Each parameter defines a schema.
* [ ] Parameter types match the backend implementation.
* [ ] Parameter formats are correctly declared.
* [ ] Required values are marked correctly.
* [ ] Optional values are not marked as required.
* [ ] Defaults match backend behavior.
* [ ] Constraints match backend validation rules.
* [ ] Parameter examples are valid.

### Path Parameters

* [ ] Every `{parameter}` in the route has a matching `in: path` declaration.
* [ ] Every `in: path` parameter appears in the route.
* [ ] Path parameter names match the route exactly.
* [ ] Path parameters are always marked `required: true`.
* [ ] Path parameter types are correct.
* [ ] UUID identifiers use `format: uuid`.
* [ ] Numeric identifiers use the correct integer format.
* [ ] Path parameters do not have default values.
* [ ] Path parameters are not nullable.

```yaml
parameters:
  - name: client-id
    in: path
    required: true
    description: Unique identifier of the client.
    schema:
      type: string
      format: uuid
```

### Query Parameters

* [ ] Query parameters are used for filtering, sorting, searching, pagination, and optional behavior.
* [ ] Query parameter names follow the API naming convention.
* [ ] Boolean query parameters use `type: boolean`.
* [ ] Date query parameters use `format: date`.
* [ ] Date-time query parameters use `format: date-time`.
* [ ] Array query parameters define serialization behavior.
* [ ] Query parameter defaults are documented.
* [ ] Query parameter minimum and maximum values are declared.
* [ ] Mutually exclusive query parameters are documented.
* [ ] Search behavior is clearly described.
* [ ] Case sensitivity is documented when important.

```yaml
- name: is-active
  in: query
  required: false
  description: Filters clients by active status.
  schema:
    type: boolean
    default: true
```

### Header Parameters

* [ ] Required custom headers are declared.
* [ ] Standard headers are not unnecessarily redefined.
* [ ] Correlation or request identifiers have the correct format.
* [ ] Tenant or organization headers are marked required when applicable.
* [ ] Header names use the expected casing.
* [ ] Sensitive headers are not exposed through examples.
* [ ] Authorization headers are represented through `security`, not as ordinary parameters.

Example:

```yaml
- name: X-Correlation-ID
  in: header
  required: false
  description: Identifier used to correlate logs across services.
  schema:
    type: string
    format: uuid
```

### Cookie Parameters

* [ ] Cookie parameters are used only when required.
* [ ] Cookie-based authentication is represented through a security scheme.
* [ ] Cookie names match the actual implementation.
* [ ] Sensitive cookie values are not included in examples.

---

## 7. Pagination

* [ ] List endpoints use the standard pagination convention.
* [ ] Pagination parameter names are consistent across APIs.
* [ ] Default page values match backend behavior.
* [ ] Page-size limits are documented.
* [ ] Minimum and maximum constraints are declared.
* [ ] Zero-based versus one-based pagination is documented.
* [ ] Pagination response metadata is documented.
* [ ] Total count behavior is documented.
* [ ] Cursor-based pagination is used for large or frequently changing datasets where appropriate.
* [ ] Cursor values are treated as opaque strings.
* [ ] Pagination links or continuation tokens are documented where applicable.

Example using page-based pagination:

```yaml
- name: page-number
  in: query
  required: false
  description: One-based page number.
  schema:
    type: integer
    format: int32
    minimum: 1
    default: 1

- name: page-size
  in: query
  required: false
  description: Number of records returned per page.
  schema:
    type: integer
    format: int32
    minimum: 1
    maximum: 100
    default: 20
```

* [ ] Paginated responses use the standard response envelope.
* [ ] The response body includes `content` for records and `metadata` for pagination details.
* [ ] Pagination metadata property names match the pagination query parameter convention.

```yaml
'200':
  description: Clients retrieved successfully.
  content:
    application/json:
      schema:
        type: object
        required:
          - content
          - metadata
        properties:
          content:
            type: array
            items:
              $ref: '#/components/schemas/ClientResponse'
          metadata:
            type: object
            required:
              - page-number
              - page-size
              - total-count
              - total-pages
            properties:
              page-number:
                type: integer
                format: int32
                minimum: 1
              page-size:
                type: integer
                format: int32
                minimum: 1
              total-count:
                type: integer
                format: int64
                minimum: 0
              total-pages:
                type: integer
                format: int32
                minimum: 0
```

---

## 8. Request Body

* [ ] A request body is included for `POST`, `PUT`, and `PATCH` when required.
* [ ] The request body is omitted from `GET` and `DELETE` unless there is a strong documented reason.
* [ ] `requestBody.required` is set correctly.
* [ ] Supported media types are declared.
* [ ] The request schema uses a component reference where reusable.
* [ ] The request schema matches the actual API input model.
* [ ] Request-only fields are not reused from response DTOs unless the models are truly identical.
* [ ] Server-generated fields are excluded from create requests.
* [ ] Immutable fields are excluded from update requests.
* [ ] Patch request models contain only fields that can be changed.
* [ ] Validation constraints match FluentValidation, data annotations, or domain rules.
* [ ] Required request properties are declared.
* [ ] Examples are valid and realistic.
* [ ] Sensitive information is redacted from examples.

```yaml
requestBody:
  required: true
  content:
    application/json:
      schema:
        $ref: '#/components/schemas/CreateClientRequest'
      examples:
        standard:
          value:
            name: Contoso Ltd
            email: contact@contoso.example
```

### Content Types

* [ ] `application/json` is declared for JSON requests.
* [ ] `multipart/form-data` is declared for file uploads.
* [ ] `application/octet-stream` is used only when appropriate.
* [ ] `application/json-patch+json` is declared for JSON Patch operations.
* [ ] The documented content types match controller configuration.
* [ ] Unsupported content types are not advertised.

### File Upload Requests

* [ ] File properties use `type: string` and `format: binary`.
* [ ] Maximum file size is documented.
* [ ] Allowed file extensions are documented.
* [ ] Allowed MIME types are documented.
* [ ] Multiple files use an array with binary items.
* [ ] Additional form fields are declared.

```yaml
requestBody:
  required: true
  content:
    multipart/form-data:
      schema:
        type: object
        required:
          - file
        properties:
          file:
            type: string
            format: binary
```

---

## 9. Request and Response DTO Separation

* [ ] Create, update, and response models are separated when their fields differ.
* [ ] Server-managed fields are not accepted in request models.
* [ ] Audit fields appear only in response models unless explicitly writable.
* [ ] Database entities are not directly exposed as API schemas.
* [ ] Internal navigation properties are not exposed.
* [ ] Request models do not contain response-only metadata.
* [ ] Response models do not expose internal IDs unnecessarily.

Recommended separation:

```text
CreateClientRequest
UpdateClientRequest
ClientResponse
ClientSummaryResponse
PagedClientResponse
```

Example:

```yaml
CreateClientRequest:
  type: object
  required:
    - name
    - email
  properties:
    name:
      type: string
      minLength: 1
      maxLength: 200
    email:
      type: string
      format: email

ClientResponse:
  type: object
  required:
    - id
    - name
    - email
    - createdAt
  properties:
    id:
      type: string
      format: uuid
      readOnly: true
    name:
      type: string
    email:
      type: string
      format: email
    createdAt:
      type: string
      format: date-time
      readOnly: true
```

---

## 10. Response Definitions

### Success Responses

* [ ] All expected success response codes are documented.
* [ ] Response codes match actual controller behavior.
* [ ] Response descriptions are meaningful.
* [ ] Response content types are declared.
* [ ] Response schemas match actual response DTOs.
* [ ] Response examples are valid.
* [ ] Response headers are documented when applicable.

Common response codes:

* [ ] `200 OK` for successful retrieval or update with a response body.
* [ ] `201 Created` for successful resource creation.
* [ ] `202 Accepted` for asynchronous processing.
* [ ] `204 No Content` for successful operations without a response body.
* [ ] `206 Partial Content` only when partial-content semantics are implemented.

### 200 OK

* [ ] A response schema is provided.
* [ ] Collection responses define array items.
* [ ] Empty collection behavior is documented.

```yaml
'200':
  description: Clients retrieved successfully.
  content:
    application/json:
      schema:
        type: array
        items:
          $ref: '#/components/schemas/ClientResponse'
```

### 201 Created

* [ ] The created resource or identifier is returned where required.
* [ ] The `Location` header is documented where supported.
* [ ] The response schema matches the create operation output.

```yaml
'201':
  description: Client created successfully.
  headers:
    Location:
      description: URL of the newly created client.
      schema:
        type: string
        format: uri
  content:
    application/json:
      schema:
        $ref: '#/components/schemas/ClientResponse'
```

### 204 No Content

* [ ] The response does not contain `content`.
* [ ] No response schema is declared.
* [ ] No response body example is provided.
* [ ] The backend actually returns an empty body.

Correct:

```yaml
'204':
  description: Client deleted successfully.
```

Incorrect:

```yaml
'204':
  description: Client deleted successfully.
  content:
    application/json:
      schema:
        type: object
```

---

## 11. Error Responses

* [ ] All expected error responses are documented.
* [ ] Error behavior matches centralized exception handling.
* [ ] Errors use the common `ErrorResponseDto`.
* [ ] Error examples do not expose stack traces.
* [ ] Internal exception messages are not exposed.
* [ ] Validation errors provide useful field-level information.
* [ ] Correlation or trace identifiers are included where supported.

Common error responses:

* [ ] `400 Bad Request`
* [ ] `401 Unauthorized`
* [ ] `403 Forbidden`
* [ ] `404 Not Found`
* [ ] `409 Conflict`
* [ ] `415 Unsupported Media Type`
* [ ] `422 Unprocessable Entity`, if used by the API standard
* [ ] `429 Too Many Requests`, if rate limiting is enabled
* [ ] `500 Internal Server Error`
* [ ] `502 Bad Gateway`, where the gateway can produce it
* [ ] `503 Service Unavailable`, where appropriate
* [ ] `504 Gateway Timeout`, where appropriate


Example reusable response:

```yaml
components:
  responses:
    BadRequest:
      description: The request is invalid.
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorResponseDto'

    Unauthorized:
      description: Authentication is required or invalid.
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorResponseDto'

    Forbidden:
      description: The caller does not have permission to perform this operation.
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorResponseDto'

    NotFound:
      description: The requested resource was not found.
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorResponseDto'

    InternalServerError:
      description: An unexpected server error occurred.
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorResponseDto'
```

---

## 12. Error Response DTO

* [ ] The common error schema is defined in `components.schemas`.
* [ ] Required fields are declared.
* [ ] The schema matches the centralized exception-handling middleware.
* [ ] Validation errors are represented consistently.
* [ ] Trace and correlation identifiers use consistent names.
* [ ] Sensitive internal data is not included.

Example:

```yaml
ErrorResponseDto:
  type: object
  required:
    - statusCode
    - message
    - traceId
  properties:
    statusCode:
      type: integer
      format: int32
      example: 400
    errorCode:
      type: string
      nullable: true
      example: CLIENT_VALIDATION_ERROR
    message:
      type: string
      example: The request contains invalid values.
    traceId:
      type: string
      example: 00-abcd1234ef567890-abcd1234ef567890-01
    errors:
      type: array
      nullable: true
      items:
        $ref: '#/components/schemas/ValidationErrorDto'
```

```yaml
ValidationErrorDto:
  type: object
  required:
    - field
    - messages
  properties:
    field:
      type: string
      example: email
    messages:
      type: array
      items:
        type: string
      example:
        - Email must be a valid email address.
```

---

## 13. Reusable Components

* [ ] Reusable schemas are defined under `components.schemas`.
* [ ] Reusable responses are defined under `components.responses`.
* [ ] Reusable parameters are defined under `components.parameters`.
* [ ] Reusable headers are defined under `components.headers`.
* [ ] Reusable request bodies are defined under `components.requestBodies` where useful.
* [ ] Security schemes are defined under `components.securitySchemes`.
* [ ] Duplicate inline definitions are replaced with shared components.
* [ ] Components have clear, unique names.
* [ ] Component names follow the API naming convention.
* [ ] Components do not create circular references unsupported by client generators.

---

## 14. Schema Design

### Required Properties

* [ ] Every required property exists under `properties`.
* [ ] Optional properties are not included in `required`.
* [ ] Required fields match application validation rules.
* [ ] Required fields do not conflict with nullable definitions.
* [ ] Create and update request requirements are reviewed separately.

Correct:

```yaml
ClientResponse:
  type: object
  required:
    - id
    - name
  properties:
    id:
      type: string
      format: uuid
    name:
      type: string
```

Incorrect:

```yaml
ClientResponse:
  type: object
  required:
    - clientName
  properties:
    name:
      type: string
```

### Data Types and Formats

* [ ] String identifiers use the correct format.
* [ ] UUID values use `type: string` and `format: uuid`.
* [ ] Dates use `type: string` and `format: date`.
* [ ] Timestamps use `type: string` and `format: date-time`.
* [ ] Email addresses use `format: email`.
* [ ] URLs use `format: uri`.
* [ ] Binary values use `format: binary` or `byte`, as appropriate.
* [ ] 32-bit integers use `format: int32`.
* [ ] 64-bit integers use `format: int64`.
* [ ] Floating-point values use `format: float` or `double`.
* [ ] Decimal values are documented carefully to avoid generated-client precision issues.
* [ ] Boolean values use `type: boolean`.
* [ ] Enums list every allowed value.
* [ ] Enum casing matches the serialized API values.

Example:

```yaml
properties:
  id:
    type: string
    format: uuid
  sequenceNumber:
    type: integer
    format: int64
  eventDate:
    type: string
    format: date
  createdAt:
    type: string
    format: date-time
```

### String Constraints

* [ ] `minLength` is defined when empty strings are invalid.
* [ ] `maxLength` matches backend and database constraints.
* [ ] `pattern` is included only when necessary.
* [ ] Regex patterns are compatible with validation tooling.
* [ ] String trimming behavior is documented if relevant.

### Numeric Constraints

* [ ] `minimum` and `maximum` are defined.
* [ ] Inclusive versus exclusive bounds are correct.
* [ ] `multipleOf` is used where relevant.
* [ ] Negative values are prohibited where invalid.
* [ ] Decimal precision expectations are documented.

### Arrays

* [ ] Every array defines `items`.
* [ ] Array item schemas are valid.
* [ ] Minimum and maximum item counts are defined where appropriate.
* [ ] Duplicate-item behavior is documented.
* [ ] `uniqueItems: true` is used only when uniqueness is enforced.
* [ ] Empty-array behavior is documented.
* [ ] Nullable array and nullable item behavior are distinguished.

```yaml
clientIds:
  type: array
  minItems: 1
  items:
    type: string
    format: uuid
```

### Objects

* [ ] Object properties are explicitly defined.
* [ ] Arbitrary properties are not accepted unless intentional.
* [ ] `additionalProperties` is configured appropriately.
* [ ] Dictionary value types are defined.
* [ ] Nested objects are moved into reusable schemas when complex.

Example dictionary:

```yaml
metadata:
  type: object
  additionalProperties:
    type: string
```

---

## 15. Nullability

* [ ] Nullable fields are explicitly identified.
* [ ] Required and nullable are treated as separate concepts.
* [ ] Nullable behavior matches JSON serialization settings.
* [ ] Nullable reference types in C# match the OpenAPI schema.
* [ ] Optional fields are not assumed to be nullable automatically.
* [ ] Null behavior is documented for patch operations.

OpenAPI 3.0 example:

```yaml
middleName:
  type: string
  nullable: true
```

OpenAPI 3.1 example:

```yaml
middleName:
  type:
    - string
    - 'null'
```

* [ ] OpenAPI 3.0 `nullable` syntax is not used in an incompatible OpenAPI 3.1 workflow.
* [ ] OpenAPI 3.1 union types are not used with tools that only support OpenAPI 3.0.

---

## 16. Read-Only and Write-Only Fields

### Read-Only

* [ ] Server-generated fields are marked `readOnly: true`.
* [ ] IDs generated by the server are read-only.
* [ ] Created and modified timestamps are read-only.
* [ ] Audit-user fields are read-only.
* [ ] Calculated values are read-only.
* [ ] Read-only fields are not required in request payloads.

```yaml
createdAt:
  type: string
  format: date-time
  readOnly: true
```

### Write-Only

* [ ] Passwords and secrets are marked `writeOnly: true`.
* [ ] Write-only fields are not returned in response examples.
* [ ] Sensitive inputs are not included in logs or documentation examples.
* [ ] Write-only fields are used only when the same schema is intentionally shared.

```yaml
password:
  type: string
  format: password
  writeOnly: true
```

---

## 17. Enums

* [ ] Enum values match serialized backend values exactly.
* [ ] Enum casing is consistent.
* [ ] Enum descriptions explain the business meaning.
* [ ] Unknown-value behavior is considered for generated clients.
* [ ] Numeric enums are avoided unless required.
* [ ] Adding new enum values will not unexpectedly break generated clients.
* [ ] Enum schemas are reused through `$ref`.

```yaml
ClientStatus:
  type: string
  description: Current status of the client.
  enum:
    - active
    - inactive
    - suspended
```

---

## 18. Schema Composition

* [ ] `allOf` is used only when schema composition is required.
* [ ] `oneOf` is used when exactly one schema must match.
* [ ] `anyOf` is used only when multiple schemas may match.
* [ ] A discriminator is defined for polymorphic schemas where required.
* [ ] Client-generation support for composition is verified.
* [ ] Inheritance does not create duplicate or conflicting properties.
* [ ] Required fields are correctly inherited.

Example:

```yaml
Animal:
  type: object
  required:
    - animalType
  properties:
    animalType:
      type: string
  discriminator:
    propertyName: animalType
    mapping:
      dog: '#/components/schemas/Dog'
      cat: '#/components/schemas/Cat'
```

---

## 19. Examples

* [ ] Important request bodies include examples.
* [ ] Important success responses include examples.
* [ ] Validation errors include examples.
* [ ] Authentication errors include examples where useful.
* [ ] Examples conform to their schemas.
* [ ] UUID examples are valid UUIDs.
* [ ] Date-time examples use ISO 8601.
* [ ] Enum examples use valid values.
* [ ] Required properties are included.
* [ ] Read-only properties are excluded from request examples.
* [ ] Write-only properties are excluded from response examples.
* [ ] Examples do not contain real credentials or personal data.
* [ ] Example values are realistic enough to support consumer understanding.
* [ ] Multiple scenarios use named examples where helpful.

```yaml
examples:
  activeClient:
    summary: Active client
    value:
      id: 9fa52b46-80da-4aa1-8719-a295845d4af3
      name: Contoso Ltd
      status: active
      createdAt: '2026-07-22T08:30:00Z'
```

---

## 20. Authentication and Authorization

### Security Scheme

* [ ] The security scheme is defined under `components.securitySchemes`.
* [ ] The scheme matches the actual authentication mechanism.
* [ ] Bearer authentication uses the correct syntax.
* [ ] JWT is declared using `scheme: bearer`.
* [ ] `bearerFormat: JWT` is included for documentation.
* [ ] OAuth scopes are documented where applicable.
* [ ] API keys specify their location and header or query name.
* [ ] Sensitive credentials are not included in examples.

JWT example:

```yaml
components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT
```

### Operation Security

* [ ] Secured endpoints include a `security` requirement.
* [ ] Public endpoints explicitly override global security when needed.
* [ ] Security requirements match ASP.NET Core authorization policies.
* [ ] Role-based requirements are documented.
* [ ] Policy-based requirements are documented.
* [ ] Tenant or organization restrictions are documented.
* [ ] `401` and `403` responses are included for secured operations.

Global security:

```yaml
security:
  - bearerAuth: []
```

Public-operation override:

```yaml
security: []
```

### OAuth 2.0

* [ ] The OAuth flow matches the actual identity provider configuration.
* [ ] Authorization and token URLs are correct.
* [ ] Scopes are declared.
* [ ] Operations request the correct scopes.
* [ ] Environment-specific URLs are not accidentally hard-coded.

---

## 21. Response Headers

* [ ] Important response headers are documented with schema types and examples.
* [ ] Standard headers such as `Location`, `Retry-After`, correlation IDs, and deprecation headers are included only when used.
* [ ] Pagination headers are not documented unless the API uses header-based pagination.

---

## 22. Content Negotiation

* [ ] Supported request and response media types match actual service behavior.
* [ ] JSON, file download MIME types, and charset assumptions are declared only when relevant.
* [ ] `406 Not Acceptable` and `415 Unsupported Media Type` are documented if enforced.

---

## 23. File Download Endpoints

* [ ] The response MIME type matches the generated file.
* [ ] The response schema uses `type: string` and `format: binary`.
* [ ] The `Content-Disposition` header is documented.
* [ ] Possible file-generation errors are documented.
* [ ] Empty-file behavior is documented.
* [ ] Large-file or streaming behavior is documented where relevant.

```yaml
'200':
  description: Export file generated successfully.
  headers:
    Content-Disposition:
      description: Indicates the downloaded filename.
      schema:
        type: string
  content:
    application/vnd.openxmlformats-officedocument.spreadsheetml.sheet:
      schema:
        type: string
        format: binary
```

---

## 24. Asynchronous Operations

* [ ] Long-running operations use `202 Accepted` where appropriate.
* [ ] The response includes a job or operation identifier.
* [ ] A status endpoint is documented.
* [ ] Possible operation states are documented.
* [ ] Retry or polling guidance is documented.
* [ ] Completion and failure responses are defined.
* [ ] SignalR or webhook notification behavior is documented separately where used.
* [ ] RabbitMQ or internal message-broker details are not exposed unnecessarily to external API consumers.

Example:

```yaml
'202':
  description: Import request accepted for processing.
  content:
    application/json:
      schema:
        $ref: '#/components/schemas/OperationAcceptedResponse'
```

---

## 25. Idempotency

* [ ] Idempotent methods behave idempotently.
* [ ] `PUT` and `DELETE` retry behavior is documented.
* [ ] Create operations support an idempotency key where needed.
* [ ] The idempotency header is documented.
* [ ] Duplicate request handling is defined.
* [ ] Idempotency key retention behavior is documented.
* [ ] Conflict responses are documented.

Example:

```yaml
- name: Idempotency-Key
  in: header
  required: false
  description: Unique key used to prevent duplicate processing.
  schema:
    type: string
    maxLength: 100
```

---

## 26. Concurrency Control

* [ ] Optimistic concurrency behavior is documented.
* [ ] ETag usage is documented where applicable.
* [ ] `If-Match` or version parameters are declared.
* [ ] Stale-update behavior is documented.
* [ ] Concurrency conflicts return an appropriate response such as `409` or `412`.
* [ ] The response schema for concurrency errors is defined.

---

## 27. Filtering, Sorting, and Searching

* [ ] Filter parameter names are consistent.
* [ ] Supported filter operators are documented.
* [ ] Search fields are documented.
* [ ] Full-text versus exact-match behavior is documented.
* [ ] Sorting parameter syntax is documented.
* [ ] Supported sort fields are documented.
* [ ] Ascending and descending syntax is documented.
* [ ] Invalid filter or sort fields return a documented error.
* [ ] Filtering does not allow direct injection of SQL or internal property names.

Example:

```yaml
- name: sort-by
  in: query
  required: false
  schema:
    type: string
    enum:
      - name
      - createdAt

- name: sort-direction
  in: query
  required: false
  schema:
    type: string
    enum:
      - asc
      - desc
    default: asc
```

---

## 28. API Gateway Compatibility

For APIs exposed through Ocelot or another API gateway:

* [ ] The documented public path matches the gateway route.
* [ ] The gateway does not rewrite the route differently from the specification.
* [ ] Upstream and downstream paths are correctly mapped.
* [ ] HTTP methods allowed by the gateway match the OpenAPI operation.
* [ ] Authentication requirements match gateway configuration.
* [ ] Required headers are forwarded.
* [ ] Correlation IDs are propagated.
* [ ] Query parameters are forwarded correctly.
* [ ] Request and response size limits are considered.
* [ ] Gateway-generated responses are documented when consumers may receive them.
* [ ] Timeout behavior is documented where relevant.
* [ ] Rate-limit responses are included where enabled.
* [ ] Service-internal routes are not accidentally exposed as public routes.

---

## 29. ASP.NET Core and C# Alignment

* [ ] Routes, HTTP methods, and parameter names match controller or minimal API definitions.
* [ ] Request and response schemas match public API DTOs, not internal MediatR contracts unless intentionally exposed.
* [ ] C# types map to the expected OpenAPI formats, including `Guid`, `long`, `DateOnly`, `DateTime`, and `DateTimeOffset`.
* [ ] Nullable reference types, enum serialization, JSON naming policies, and custom converters are reflected correctly.
* [ ] FluentValidation, `ProducesResponseType`, exception middleware, authorization policies, and file bindings match the specification.

---

## 30. Deprecation

* [ ] Deprecated operations use `deprecated: true`.
* [ ] The replacement operation is identified in the description.
* [ ] The deprecation date is documented.
* [ ] The removal date or target version is documented where known.
* [ ] Deprecated schemas and parameters are identified.
* [ ] Deprecated operations remain valid until the announced removal date.
* [ ] Client-generation impact is reviewed.

```yaml
deprecated: true
description: >
  This endpoint is deprecated. Use GET /client/v2/clients/{client-id}
  instead.
```

---

## 31. YAML and JSON Quality

* [ ] The YAML parses successfully.
* [ ] Indentation is consistent.
* [ ] Tabs are not used for indentation.
* [ ] Strings containing special characters are quoted where necessary.
* [ ] Duplicate YAML keys do not exist.
* [ ] Boolean values are represented correctly.
* [ ] Date-like strings are quoted when required.
* [ ] Empty objects and arrays are intentional.
* [ ] Comments do not contain outdated information.
* [ ] The specification can be converted between YAML and JSON without data loss.

---

## 32. Performance and Operational Concerns

* [ ] List endpoints require pagination where result sets can grow.
* [ ] Maximum page size is defined.
* [ ] Expensive expansions or includes are controlled.
* [ ] Large response payloads, file-size limits, and timeouts are documented where consumers need to account for them.
* [ ] Rate-limit and retry behavior are documented for transient failures.
* [ ] Asynchronous processing is used for long-running operations.
* [ ] Bulk and batch request limits are documented, including `maxItems` where applicable.

