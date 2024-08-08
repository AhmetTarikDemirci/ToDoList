# Project: API documentation
# 📄 Get started here

This template contains a boilerplate for documentation that you can quickly customize and reuse.

## 🔖 How to use this template

- Replace the content given brackets (()) with your API's details.
    
- Tips are formatted in `codespan` - feel free to read and remove them.
    

---

`Start with a brief overview of what your API offers.`

The ((product name)) provides many API products, tools, and resources that enable you to ((add product value here)).

`You can also list the APIs you offer, link to the relevant pages, or do both in this section.`

## **Getting started guide**

`List the steps or points required to start using your APIs. Make sure to cover everything required to reach success with your API as quickly as possible.`

To start using the ((add APIs here)), you need to -

`The points given below are from The Postman API's documentation. You can reference it to write your own getting started guide.`

- You must use a valid API Key to send requests to the API endpoints. You can get your API key from Postman's [integrations dashboard](https://go.postman.co/settings/me/api-keys).
    
- The API has [rate and usage limits](https://learning.postman.com/docs/developer/postman-api/postman-api-rate-limits/).
    
- The API only responds to HTTPS-secured communications. Any requests sent via HTTP return an HTTP 301 redirect to the corresponding HTTPS resources.
    
- The API returns request responses in JSON format. When an API request returns an error, it is sent in the JSON response as an error key.
    

## Authentication

`Add details on the authorization keys/tokens required, steps that cover how to get them, and the relevant error codes.`

The ((product name)) API uses ((add your API's authorization type)) for authentication.

`The details given below are from the Postman API's documentation. You can reference it to write your own authentication section.`

Postman uses API keys for authentication. You can generate a Postman API key in the [API keys](https://postman.postman.co/settings/me/api-keys) section of your Postman account settings.

You must include an API key in each request to the Postman API with the X-Api-Key request header.

### Authentication error response

If an API key is missing, malformed, or invalid, you will receive an HTTP 401 Unauthorized response code.

## Rate and usage limits

`Use this section to cover your APIs' terms of use. Include API limits, constraints, and relevant error codes, so consumers understand the permitted API usage and practices.`

`The example given below is from The Postman API's documentation. Use it as a reference to write your APIs' terms of use.`

API access rate limits apply at a per-API key basis in unit time. The limit is 300 requests per minute. Also, depending on your plan, you may have usage limits. If you exceed either limit, your request will return an HTTP 429 Too Many Requests status code.

Each API response returns the following set of headers to help you identify your use status:

| Header | Description |
| --- | --- |
| `X-RateLimit-Limit` | The maximum number of requests that the consumer is permitted to make per minute. |
| `X-RateLimit-Remaining` | The number of requests remaining in the current rate limit window. |
| `X-RateLimit-Reset` | The time at which the current rate limit window resets in UTC epoch seconds. |

### 503 response

An HTTP `503` response from our servers indicates there is an unexpected spike in API access traffic. The server is usually operational within the next five minutes. If the outage persists or you receive any other form of an HTTP `5XX` error, [contact support](https://support.postman.com/hc/en-us/requests/new/).

### **Need some help?**

`Add links that customers can refer to whenever they need help.`

In case you have questions, go through our tutorials ((link to your video or help documentation here)). Or visit our FAQ page ((link to the relevant page)).

Or you can check out our community forum, there’s a good chance our community has an answer for you. Visit our developer forum ((link to developer forum)) to review topics, ask questions, and learn from others.

`You can also document or add links to libraries, code examples, and other resources needed to make a request.`
# 📁 Collection: ToDoListApp 


## End-point: Login
Bu istek, kullanıcı girişini gerçekleştirmek için kullanılır. Kullanıcı e-posta adresi ve şifresini kullanarak giriş yapar. Başarılı bir giriş sonucunda, JWT token ve kullanıcı bilgileri döner.

Gönderilecek JSON verisi şu alanları içermelidir:

- `email`: Kullanıcının e-posta adresi.
    
- `password`: Kullanıcının şifresi.
    

Başarılı bir istek sonucunda sunucu, kullanıcı bilgilerini ve JWT token içeren bir JSON yanıtı döner. Yanıt şu alanları içerir:

- `success`: İsteğin başarılı olup olmadığını belirten bayrak (1: Başarılı, 0: Başarısız).
    
- `message`: İşlemle ilgili mesaj.
    
- `token`: Kullanıcının JWT token'ı.
    
- `user`: Kullanıcı bilgilerini içeren nesne.
    
    - `id`: Kullanıcının benzersiz kimliği.
        
    - `user_name`: Kullanıcının kullanıcı adı.
        
    - `email`: Kullanıcının e-posta adresi.
        
    - `date_of_registration`: Kullanıcının kayıt tarihi (timestamp formatında).
        

# **HATALI DURUMLAR VE YANITLAR**

Geçersiz e-posta veya şifre ile giriş yapılmaya çalışıldığında sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 401 (Unauthorized)
    
- `success`: 0
    
- `message`: "Geçersiz e-posta veya şifre"
    

Gerekli alanlardan herhangi biri eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `success`: 0
    
- `message`: "Gerekli alan(lar) eksik"
    

Giriş sırasında bir sunucu hatası oluştuğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 500 (Internal Server Error)
    
- `success`: 0
    
- `message`: "Sunucu hatası: \[hata mesajı\]"
### Method: POST
>```
>https://ahmettarikdemirci.io/todolist/login
>```
### Body (**raw**)

```json
{
    "email": "ahmettarikdemirci@gmail.com",
    "password": "masque12"
}

```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Register
Bu istek, yeni bir kullanıcı kaydı oluşturmak için kullanılır. Kullanıcı adı, e-posta adresi ve şifre bilgileri içeren bir JSON verisi gönderilir ve kayıt başarılı olursa, kullanıcı detaylarını ve JWT token içeren bir JSON yanıtı döner.

Gönderilecek JSON verisi şu alanları içermelidir:

- `user_name`: Kullanıcının kullanıcı adı.
    
- `email`: Kullanıcının e-posta adresi.
    
- `password`: Kullanıcının şifresi.
    

Başarılı bir istek sonucunda sunucu, kullanıcı bilgilerini ve JWT token içeren bir JSON yanıtı döner. Yanıt şu alanları içerir:

- `success`: İsteğin başarılı olup olmadığını belirten bayrak (1: Başarılı, 0: Başarısız).
    
- `message`: İşlemle ilgili mesaj.
    
- `token`: Kullanıcının JWT token'ı.
    
- `user`: Kullanıcı bilgilerini içeren nesne.
    
    - `id`: Kullanıcının benzersiz kimliği.
        
    - `user_name`: Kullanıcının kullanıcı adı.
        
    - `email`: Kullanıcının e-posta adresi.
        
    - `date_of_registration`: Kullanıcının kayıt tarihi (timestamp formatında).
        

# **HATALI DURUMLAR VE YANITLAR**

E-posta adresi zaten kayıtlı olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 409 (Conflict)
    
- `success`: 0
    
- `message`: "Bu e-posta adresi zaten kayıtlı"
    

Kullanıcı adı zaten kayıtlı olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 409 (Conflict)
    
- `success`: 0
    
- `message`: "Bu kullanıcı adı zaten kayıtlı"
    

Gerekli alanlardan herhangi biri eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `success`: 0
    
- `message`: "Gerekli alan(lar) eksik"
    

Kullanıcı kaydı sırasında bir hata oluştuğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 500 (Internal Server Error)
    
- `success`: 0
    
- `message`: "Kayıt başarısız: \[hata mesajı\]"
### Method: POST
>```
>https://ahmettarikdemirci.io/todolist/register
>```
### Body (**raw**)

```json
{
    "user_name": "Mehmet6",
    "email": "ahmettarik2@gmail.com",
    "password": "masque12"
}

```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Update Username
Bu istek, kullanıcının kullanıcı adını güncellemek için kullanılır. Kullanıcı adı ve şifre bilgileri içeren bir JSON verisi gönderilir. Şifre doğrulanırsa, kullanıcı adı güncellenir ve başarılı bir yanıt döner.

Bu istek, Bearer Token yetkilendirmesi gerektirir. Lütfen geçerli bir token ile istek gönderin.

Gönderilecek JSON verisi şu alanları içermelidir:

- `user_name`: Yeni kullanıcı adı.
    
- `password`: Mevcut kullanıcı şifresi.
    

Başarılı bir istek sonucunda sunucu, kullanıcı adının başarıyla güncellendiğini belirten bir JSON yanıtı döner. Yanıt şu alanları içerir:

- `success`: İsteğin başarılı olup olmadığını belirten bayrak (1: Başarılı, 0: Başarısız).
    
- `message`: İşlemle ilgili mesaj.
    

# **HATALI DURUMLAR VE YANITLAR**

Gönderilen şifre geçersiz olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `success`: 0
    
- `message`: "Geçersiz şifre"
    

Gerekli alanlardan herhangi biri eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `success`: 0
    
- `message`: "Gerekli alan(lar) eksik"
    

Kullanıcı adı güncellenirken bir hata oluştuğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 500 (Internal Server Error)
    
- `success`: 0
    
- `message`: "Güncelleme başarısız: \[hata mesajı\]"
    

Geçersiz veya eksik token ile erişim yapılmaya çalışıldığında sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 401 (Unauthorized)
    
- `success`: 0
    
- `message`: "Yetkilendirme hatası: \[hata mesajı\]"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `success`: 0
    
- `message`: "Token bulunamadı"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `success`: 0
    
- `message`: "Authorization başlığı eksik"
### Method: POST
>```
>https://ahmettarikdemirci.io/todolist/update_username
>```
### Body (**raw**)

```json
{
    "user_name": "TarıkDemirci",
    "password": "masque12"
}

```

### 🔑 Authentication bearer

|Param|value|Type|
|---|---|---|
|token|eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FobWV0dGFyaWtkZW1pcmNpLmlvIiwiaWF0IjoxNzIyMjE2NzMxLCJleHAiOjEuMGUrNDUsInVzZXJfaWQiOjF9.cPWhNhyHQ93YhZK91oAjxPksrwJmKX_bYjVGYEIANHs|string|



⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Update Password
Bu istek, kullanıcının şifresini güncellemek için kullanılır. Yeni şifre ve mevcut şifre bilgileri içeren bir JSON verisi gönderilir. Mevcut şifre doğrulanırsa, şifre güncellenir ve başarılı bir yanıt döner.

Bu istek, Bearer Token yetkilendirmesi gerektirir. Lütfen geçerli bir token ile istek gönderin.

Gönderilecek JSON verisi şu alanları içermelidir:

- `new_password`: Yeni şifre.
    
- `current_password`: Mevcut şifre.
    

Başarılı bir istek sonucunda sunucu, şifrenin başarıyla güncellendiğini belirten bir JSON yanıtı döner. Yanıt şu alanları içerir:

- `success`: İsteğin başarılı olup olmadığını belirten bayrak (1: Başarılı, 0: Başarısız).
    
- `message`: İşlemle ilgili mesaj.
    

# **HATALI DURUMLAR VE YANITLAR**

Gönderilen mevcut şifre geçersiz olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `success`: 0
    
- `message`: "Geçersiz mevcut şifre"
    

Gerekli alanlardan herhangi biri eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `success`: 0
    
- `message`: "Gerekli alan(lar) eksik"
    

Şifre güncellenirken bir hata oluştuğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 500 (Internal Server Error)
    
- `success`: 0
    
- `message`: "Güncelleme başarısız: \[hata mesajı\]"
    

Geçersiz veya eksik token ile erişim yapılmaya çalışıldığında sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 401 (Unauthorized)
    
- `success`: 0
    
- `message`: "Yetkilendirme hatası: \[hata mesajı\]"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `success`: 0
    
- `message`: "Token bulunamadı"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `success`: 0
    
- `message`: "Authorization başlığı eksik"
### Method: POST
>```
>https://ahmettarikdemirci.io/todolist/update_password
>```
### Body (**raw**)

```json
{
    "new_password": "123456",
    "current_password": "masque12"
}
```

### 🔑 Authentication bearer

|Param|value|Type|
|---|---|---|
|token|eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FobWV0dGFyaWtkZW1pcmNpLmlvIiwiaWF0IjoxNzIyMjE2NzMxLCJleHAiOjEuMGUrNDUsInVzZXJfaWQiOjF9.cPWhNhyHQ93YhZK91oAjxPksrwJmKX_bYjVGYEIANHs|string|



⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Update Email
Bu istek, kullanıcının e-posta adresini güncellemek için kullanılır. Yeni e-posta adresi ve mevcut şifre bilgileri içeren bir JSON verisi gönderilir. Mevcut şifre doğrulanırsa, e-posta adresi güncellenir ve başarılı bir yanıt döner.

Bu istek, Bearer Token yetkilendirmesi gerektirir. Lütfen geçerli bir token ile istek gönderin.

Gönderilecek JSON verisi şu alanları içermelidir:

- `email`: Yeni e-posta adresi.
    
- `password`: Mevcut şifre.
    

Başarılı bir istek sonucunda sunucu, e-posta adresinin başarıyla güncellendiğini belirten bir JSON yanıtı döner. Yanıt şu alanları içerir:

- `success`: İsteğin başarılı olup olmadığını belirten bayrak (1: Başarılı, 0: Başarısız).
    
- `message`: İşlemle ilgili mesaj.
    

# **HATALI DURUMLAR VE YANITLAR**

Gönderilen mevcut şifre geçersiz olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `success`: 0
    
- `message`: "Geçersiz şifre"
    

Gerekli alanlardan herhangi biri eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `success`: 0
    
- `message`: "Gerekli alan(lar) eksik"
    

E-posta adresi güncellenirken bir hata oluştuğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 500 (Internal Server Error)
    
- `success`: 0
    
- `message`: "Güncelleme başarısız: \[hata mesajı\]"
    

Geçersiz veya eksik token ile erişim yapılmaya çalışıldığında sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 401 (Unauthorized)
    
- `success`: 0
    
- `message`: "Yetkilendirme hatası: \[hata mesajı\]"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `success`: 0
    
- `message`: "Token bulunamadı"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `success`: 0
    
- `message`: "Authorization başlığı eksik"
### Method: POST
>```
>https://ahmettarikdemirci.io/todolist/update_email
>```
### Body (**raw**)

```json
{
    "email": "new_email@example.com",
    "password": "123456"
}

```

### 🔑 Authentication bearer

|Param|value|Type|
|---|---|---|
|token|eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FobWV0dGFyaWtkZW1pcmNpLmlvIiwiaWF0IjoxNzIyMjE2NzMxLCJleHAiOjEuMGUrNDUsInVzZXJfaWQiOjF9.cPWhNhyHQ93YhZK91oAjxPksrwJmKX_bYjVGYEIANHs|string|



⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Delete Account
Bu istek, kullanıcının hesabını silmek için kullanılır. İstek, JWT token ile yetkilendirilmelidir ve başarılı olursa kullanıcı başarıyla silindiğini belirten bir yanıt döner.

Bu istek, Bearer Token yetkilendirmesi gerektirir. Lütfen geçerli bir token ile istek gönderin.

Başarılı bir istek sonucunda sunucu, kullanıcının başarıyla silindiğini belirten bir JSON yanıtı döner. Yanıt şu alanları içerir:

- `success`: İsteğin başarılı olup olmadığını belirten bayrak (1: Başarılı, 0: Başarısız).
    
- `message`: İşlemle ilgili mesaj.
    

# **HATALI DURUMLAR VE YANITLAR**

Kullanıcı silinirken bir hata oluştuğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 500 (Internal Server Error)
    
- `success`: 0
    
- `message`: "Kullanıcı silinirken bir hata oluştu: \[hata mesajı\]"
    

Geçersiz veya eksik token ile erişim yapılmaya çalışıldığında sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 401 (Unauthorized)
    
- `message`: "Yetkisiz erişim: \[hata mesajı\]"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Token eksik"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Authorization başlığı eksik"
### Method: DELETE
>```
>https://ahmettarikdemirci.io/todolist/delete_account
>```
### 🔑 Authentication bearer

|Param|value|Type|
|---|---|---|
|token|eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FobWV0dGFyaWtkZW1pcmNpLmlvIiwiaWF0IjoxNzIzMDM1MTA3LCJleHAiOjEuMGUrNDAsInVzZXJfaWQiOjMyfQ.J2JVRP2ONFSRZuZ_3eXYL2mnEbHcPd8jMiTs2MuF6fE|string|



⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Add Category
Bu istek, yeni bir kategori eklemek için kullanılır. Kategori ismini içeren bir JSON verisi gönderilir ve kategori başarılı bir şekilde eklenirse, kategori detaylarını içeren bir JSON yanıtı döner.

Bu istek, Bearer Token yetkilendirmesi gerektirir. Lütfen geçerli bir token ile istek gönderin.

Gönderilecek JSON verisi şu alanı içermelidir:

- `category_name`: Eklenmek istenen kategorinin adı.
    

Başarılı bir istek sonucunda sunucu, kategori detaylarını içeren bir JSON yanıtı döner. Yanıt şu alanları içerir:

- `id`: Kategorinin benzersiz kimliği.
    
- `category_name`: Kategorinin adı.
    
- `todos`: Bu kategorideki görevlerin listesi (başlangıçta boş).
    

# **HATALI DURUMLAR VE YANITLAR**

Gerekli parametrelerden herhangi biri eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Eksik parametreler."
    

Kategori veritabanına eklenirken bir hata oluştuğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Kategori eklenirken bir hata oluştu: \[hata mesajı\]"
    

Geçersiz veya eksik token ile erişim yapılmaya çalışıldığında sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 401 (Unauthorized)
    
- `message`: "Yetkisiz erişim: \[hata mesajı\]"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Token eksik"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Authorization başlığı eksik"
### Method: POST
>```
>https://ahmettarikdemirci.io/todolist/add_category
>```
### Body (**raw**)

```json
{
  "category_name": "Yeni Kategori"
}
```

### 🔑 Authentication bearer

|Param|value|Type|
|---|---|---|
|token|eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FobWV0dGFyaWtkZW1pcmNpLmlvIiwiaWF0IjoxNzIyMjE2NzMxLCJleHAiOjEuMGUrNDUsInVzZXJfaWQiOjF9.cPWhNhyHQ93YhZK91oAjxPksrwJmKX_bYjVGYEIANHs|string|



⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Delete Category
Bu istek, belirtilen bir kategoriyi ve bu kategoriye ait tüm görevleri (todo) silmek için kullanılır. Kategori kimliği (id) JSON verisi olarak gönderilir ve kategori başarılı bir şekilde silinirse, ilgili mesajı içeren bir JSON yanıtı döner.

Bu istek, Bearer Token yetkilendirmesi gerektirir. Lütfen geçerli bir token ile istek gönderin.

Gönderilecek JSON verisi şu alanı içermelidir:

- `id`: Silinecek kategorinin benzersiz kimliği.
    

Başarılı bir istek sonucunda sunucu, silinen kategori ve ilişkili tüm görevlerin başarıyla silindiğini belirten bir JSON yanıtı döner.Yanıt şu alanları içerir:

- `message`: "Kategori ve ilgili todo öğeleri başarıyla silindi."
    

# **HATALI DURUMLAR VE YANITLAR**

Gerekli parametrelerden herhangi biri eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Eksik parametreler."
    

Kategori veya ilgili görevler silinirken bir hata oluştuğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Kategori silinirken bir hata oluştu: \[hata mesajı\]"
    

Geçersiz veya eksik token ile erişim yapılmaya çalışıldığında sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 401 (Unauthorized)
    
- `message`: "Yetkisiz erişim: \[hata mesajı\]"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Token eksik"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Authorization başlığı eksik"
### Method: DELETE
>```
>https://ahmettarikdemirci.io/todolist/delete_category
>```
### Body (**raw**)

```json
{
  "id": 50
}
```

### 🔑 Authentication bearer

|Param|value|Type|
|---|---|---|
|token|eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FobWV0dGFyaWtkZW1pcmNpLmlvIiwiaWF0IjoxNzIzMDM1MTA3LCJleHAiOjEuMGUrNDAsInVzZXJfaWQiOjMyfQ.J2JVRP2ONFSRZuZ_3eXYL2mnEbHcPd8jMiTs2MuF6fE|string|



⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Get Category
Bu istek, kullanıcının tüm kategorilerini ve bu kategorilere ait tüm görevleri (todos) getirir. İstek, JWT token ile yetkilendirilmelidir ve başarılı olursa kategoriler ve ilişkili görevler JSON formatında döner.

Bu istek, Bearer Token yetkilendirmesi gerektirir. Lütfen geçerli bir token ile istek gönderin.

Başarılı bir istek sonucunda sunucu, kategoriler ve her bir kategoriye ait görevleri (todos) içeren bir JSON yanıtı döner. Yanıt şu alanları içerir:

- `id`: Kategorinin benzersiz kimliği.
    
- `category_name`: Kategorinin adı.
    
- `todos`: Kategoriye ait görevlerin listesi.
    
    - `id`: Görevin benzersiz kimliği.
        
    - `title`: Görevin başlığı.
        
    - `due_date`: Görevin tamamlanması gereken tarih ve saat.
        
    - `created_date`: Görevin oluşturulma tarihi ve saati.
        
    - `is_done`: Görevin tamamlanma durumu.
        
    - `category_id`: Görevin ait olduğu kategorinin kimliği.
        

# **HATALI DURUMLAR VE YANITLAR**

Geçersiz veya eksik token ile erişim yapılmaya çalışıldığında sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 401 (Unauthorized)
    
- `message`: "Yetkisiz erişim: \[hata mesajı\]"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Token eksik"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Authorization başlığı eksik"
### Method: GET
>```
>https://ahmettarikdemirci.io/todolist/get_todos
>```
### 🔑 Authentication bearer

|Param|value|Type|
|---|---|---|
|token|eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FobWV0dGFyaWtkZW1pcmNpLmlvIiwiaWF0IjoxNzIyMjE2NzMxLCJleHAiOjEuMGUrNDUsInVzZXJfaWQiOjF9.cPWhNhyHQ93YhZK91oAjxPksrwJmKX_bYjVGYEIANHs|string|



⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Get Todos Done
Bu istek, kullanıcının tamamlanmış tüm görevlerini (todos) kategorilere göre getirir. İstek, JWT token ile yetkilendirilmelidir ve başarılı olursa kategoriler ve ilişkili tamamlanmış görevler JSON formatında döner.  
Bu istek, Bearer Token yetkilendirmesi gerektirir. Lütfen geçerli bir token ile istek gönderin.

Başarılı bir istek sonucunda sunucu, kategoriler ve her bir kategoriye ait tamamlanmış görevleri (todos) içeren bir JSON yanıtı döner. Yanıt şu alanları içerir:

- `id`: Kategorinin benzersiz kimliği.
    
- `category_name`: Kategorinin adı.
    
- `todos`: Kategoriye ait tamamlanmış görevlerin listesi.
    
    - `id`: Görevin benzersiz kimliği.
        
    - `title`: Görevin başlığı.
        
    - `due_date`: Görevin tamamlanması gereken tarih ve saat.
        
    - `created_date`: Görevin oluşturulma tarihi ve saati.
        
    - `is_done`: Görevin tamamlanma durumu.
        
    - `category_id`: Görevin ait olduğu kategorinin kimliği.
        

# **HATALI DURUMLAR VE YANITLAR**

Geçersiz veya eksik token ile erişim yapılmaya çalışıldığında sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 401 (Unauthorized)
    
- `message`: "Yetkisiz erişim: \[hata mesajı\]"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Token eksik"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Authorization başlığı eksik"
### Method: GET
>```
>https://ahmettarikdemirci.io/todolist/get_todos_done
>```
### 🔑 Authentication bearer

|Param|value|Type|
|---|---|---|
|token|eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FobWV0dGFyaWtkZW1pcmNpLmlvIiwiaWF0IjoxNzIyMjE2NzMxLCJleHAiOjEuMGUrNDUsInVzZXJfaWQiOjF9.cPWhNhyHQ93YhZK91oAjxPksrwJmKX_bYjVGYEIANHs|string|



⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Get Todos Not Done
Bu istek, kullanıcının tamamlanmamış tüm görevlerini (todos) kategorilere göre getirir. İstek, JWT token ile yetkilendirilmelidir ve başarılı olursa kategoriler ve ilişkili tamamlanmamış görevler JSON formatında döner.

Bu istek, Bearer Token yetkilendirmesi gerektirir. Lütfen geçerli bir token ile istek gönderin.

Başarılı bir istek sonucunda sunucu, kategoriler ve her bir kategoriye ait tamamlanmamış görevleri (todos) içeren bir JSON yanıtı döner. Yanıt şu alanları içerir:

- `id`: Kategorinin benzersiz kimliği.
    
- `category_name`: Kategorinin adı.
    
- `todos`: Kategoriye ait tamamlanmamış görevlerin listesi.
    
    - `id`: Görevin benzersiz kimliği.
        
    - `title`: Görevin başlığı.
        
    - `due_date`: Görevin tamamlanması gereken tarih ve saat.
        
    - `created_date`: Görevin oluşturulma tarihi ve saati.
        
    - `is_done`: Görevin tamamlanma durumu.
        
    - `category_id`: Görevin ait olduğu kategorinin kimliği.
        

# **HATALI DURUMLAR VE YANITLAR**

Geçersiz veya eksik token ile erişim yapılmaya çalışıldığında sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 401 (Unauthorized)
    
- `message`: "Yetkisiz erişim: \[hata mesajı\]"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Token eksik"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Authorization başlığı eksik"
### Method: GET
>```
>https://ahmettarikdemirci.io/todolist/get_todos_not_done
>```
### 🔑 Authentication bearer

|Param|value|Type|
|---|---|---|
|token|eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FobWV0dGFyaWtkZW1pcmNpLmlvIiwiaWF0IjoxNzIyMjE2NzMxLCJleHAiOjEuMGUrNDUsInVzZXJfaWQiOjF9.cPWhNhyHQ93YhZK91oAjxPksrwJmKX_bYjVGYEIANHs|string|



⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Update Category
Bu istek, belirli bir kategorinin adını güncellemek için kullanılır. Kategori kimliği (id) ve yeni kategori adı içeren bir JSON verisi gönderilir. Kategori başarıyla güncellenirse, güncellenmiş kategori verisi ve ilgili tüm görevler (todos) JSON formatında döner.

Bu istek, Bearer Token yetkilendirmesi gerektirir. Lütfen geçerli bir token ile istek gönderin.

Gönderilecek JSON verisi şu alanları içermelidir:

- `id`: Güncellenecek kategorinin benzersiz kimliği.
    
- `category_name`: Yeni kategori adı.
    

Başarılı bir istek sonucunda sunucu, güncellenmiş kategori verisini ve bu kategoriye ait tüm görevleri (todos) içeren bir JSON yanıtı döner. Yanıt şu alanları içerir:

- `id`: Kategorinin benzersiz kimliği.
    
- `category_name`: Kategorinin yeni adı.
    
- `todos`: Kategoriye ait görevlerin listesi.
    
    - `id`: Görevin benzersiz kimliği.
        
    - `title`: Görevin başlığı.
        
    - `due_date`: Görevin tamamlanması gereken tarih ve saat.
        
    - `created_date`: Görevin oluşturulma tarihi ve saati.
        
    - `is_done`: Görevin tamamlanma durumu.
        
    - `category_id`: Görevin ait olduğu kategorinin kimliği.
        

# **HATALI DURUMLAR VE YANITLAR**

Gerekli parametrelerden herhangi biri eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Eksik parametreler."
    

Kategori güncellenirken bir hata oluştuğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Kategori güncellenirken bir hata oluştu: \[hata mesajı\]"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Token eksik"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Authorization başlığı eksik"
### Method: PUT
>```
>https://ahmettarikdemirci.io/todolist/edit_category
>```
### Body (**raw**)

```json
{
  "id": 30,
  "category_name": "Güncellenmiş Kategori"
}
```

### 🔑 Authentication bearer

|Param|value|Type|
|---|---|---|
|token|eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FobWV0dGFyaWtkZW1pcmNpLmlvIiwiaWF0IjoxNzIyMjE2NzMxLCJleHAiOjEuMGUrNDUsInVzZXJfaWQiOjF9.cPWhNhyHQ93YhZK91oAjxPksrwJmKX_bYjVGYEIANHs|string|



⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Add Todo
Bu istek, yeni bir görev (Todo) eklemek için kullanılır. Görev bilgilerini içeren bir JSON verisi gönderilir ve görev başarılı bir şekilde eklenirse, görev detaylarını içeren bir JSON yanıtı döner.

Bu istek, Bearer Token yetkilendirmesi gerektirir. Lütfen geçerli bir token ile istek gönderin.

Gönderilecek JSON verisi şu alanları içermelidir:

- `id`: Görevin benzersiz kimliği (UUID formatında).
    
- `title`: Görevin başlığı.
    
- `due_date`: Görevin tamamlanması gereken tarih ve saat (timestamp formatında).
    
- `created_date`: Görevin oluşturulma tarihi ve saati (timestamp formatında).
    
- `is_done`: Görevin tamamlanıp tamamlanmadığını belirten bayrak (boolean).
    
- `category_id`: Görevin ait olduğu kategorinin kimliği.
    

Başarılı bir istek sonucunda sunucu, görev detaylarını içeren bir JSON yanıtı döner. Yanıt şu alanları içerir:

- `id`: Görevin benzersiz kimliği.
    
- `title`: Görevin başlığı.
    
- `due_date`: Görevin tamamlanması gereken tarih ve saat.
    
- `created_date`: Görevin oluşturulma tarihi ve saati.
    
- `is_done`: Görevin tamamlanma durumu.
    
- `category_id`: Görevin ait olduğu kategorinin kimliği.
    

# **HATALI DURUMLAR VE YANITLAR**

Gerekli parametrelerden herhangi biri eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Eksik parametreler."
    

Görev veritabanına eklenirken bir hata oluştuğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Todo eklenirken bir hata oluştu: \[hata mesajı\]"
    

Geçersiz veya eksik token ile erişim yapılmaya çalışıldığında sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 401 (Unauthorized)
    
- `message`: "Yetkisiz erişim: \[hata mesajı\]"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Token eksik"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Authorization başlığı eksik"
### Method: POST
>```
>https://ahmettarikdemirci.io/todolist/add_todo
>```
### Body (**raw**)

```json
{
  "id": "295DDACD-18FD-4680-BA61-F1627AB22D0F",
  "title": "Yeni Todo",
  "due_date": 1722505468.47971,
  "created_date": 1722505482.53877,
  "is_done": false,
  "category_id": 28
}
```

### 🔑 Authentication bearer

|Param|value|Type|
|---|---|---|
|token|eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FobWV0dGFyaWtkZW1pcmNpLmlvIiwiaWF0IjoxNzIyMjE2NzMxLCJleHAiOjEuMGUrNDUsInVzZXJfaWQiOjF9.cPWhNhyHQ93YhZK91oAjxPksrwJmKX_bYjVGYEIANHs|string|



⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Delete Todo
Bu istek, belirtilen bir görevi (Todo) silmek için kullanılır. Görev kimliği (id) JSON verisi olarak gönderilir ve görev başarılı bir şekilde silinirse, silinen görevin detaylarını içeren bir JSON yanıtı döner.  
Bu istek, Bearer Token yetkilendirmesi gerektirir. Lütfen geçerli bir token ile istek gönderin.

Gönderilecek JSON verisi şu alanı içermelidir:

- `id`: Silinecek görevin benzersiz kimliği.
    

Başarılı bir istek sonucunda sunucu, silinen görevin detaylarını içeren bir JSON yanıtı döner. Yanıt şu alanları içerir:

- `success`: İsteğin başarılı olup olmadığını belirten bayrak (1: Başarılı, 0: Başarısız).
    
- `message`: İşlemle ilgili mesaj.
    
- `deleted_item`: Silinen görevin detaylarını içeren nesne.
    
    - `id`: Görevin benzersiz kimliği.
        
    - `title`: Görevin başlığı.
        
    - `due_date`: Görevin tamamlanması gereken tarih ve saat.
        
    - `created_date`: Görevin oluşturulma tarihi ve saati.
        
    - `is_done`: Görevin tamamlanma durumu.
        
    - `category_id`: Görevin ait olduğu kategorinin kimliği.
        

# **HATALI DURUMLAR VE YANITLAR**

Gerekli parametrelerden herhangi biri eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `success`: 0
    
- `message`: "Gerekli alan(lar) eksik"
    

Belirtilen kimlikle bir görev bulunamadığında sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 404 (Not Found)
    
- `success`: 0
    
- `message`: "Todo bulunamadı"
    

Görev veritabanından silinirken bir hata oluştuğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 500 (Internal Server Error)
    
- `success`: 0
    
- `message`: "Todo silme başarısız: \[hata mesajı\]"
    

Geçersiz veya eksik token ile erişim yapılmaya çalışıldığında sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 401 (Unauthorized)
    
- `success`: 0
    
- `message`: "Yetkisiz erişim: \[hata mesajı\]"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `success`: 0
    
- `message`: "Token eksik"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `success`: 0
    
- `message`: "Authorization başlığı eksik"
### Method: DELETE
>```
>https://ahmettarikdemirci.io/todolist/delete_todo
>```
### Body (**raw**)

```json
{
    "id": "4A8E2054-CE4F-4F20-ACA1-9E957E712D76"
}
```

### Query Params

|Param|value|
|---|---|
|||


### 🔑 Authentication bearer

|Param|value|Type|
|---|---|---|
|token|eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FobWV0dGFyaWtkZW1pcmNpLmlvIiwiaWF0IjoxNzIzMDM1MTA3LCJleHAiOjEuMGUrNDAsInVzZXJfaWQiOjMyfQ.J2JVRP2ONFSRZuZ_3eXYL2mnEbHcPd8jMiTs2MuF6fE|string|



⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Update Todo
Bu istek, belirli bir görev (todo) güncellemek için kullanılır. Görev kimliği (id), başlık (title), tamamlanma tarihi (due_date), tamamlanma durumu (is_done) ve kategori kimliği (category_id) içeren bir JSON verisi gönderilir. Kullanıcı sadece kendi görevlerini güncelleyebilir ve güncelleme başarılı olursa, başarılı bir yanıt döner.

Bu istek, Bearer Token yetkilendirmesi gerektirir. Lütfen geçerli bir token ile istek gönderin.

Gönderilecek JSON verisi şu alanları içermelidir:

- `id`: Güncellenecek görevin benzersiz kimliği.
    
- `title`: Görevin yeni başlığı.
    
- `due_date`: Görevin tamamlanması gereken yeni tarih ve saat (TimeInterval formatında).
    
- `is_done`: Görevin tamamlanma durumu (0: tamamlanmamış, 1: tamamlanmış).
    
- `category_id`: Görevin ait olduğu kategorinin kimliği.
    

Başarılı bir istek sonucunda sunucu, görevin başarıyla güncellendiğini belirten bir JSON yanıtı döner. Yanıt şu alanları içerir:

- `success`: İsteğin başarılı olup olmadığını belirten bayrak (1: Başarılı, 0: Başarısız).
    
- `message`: İşlemle ilgili mesaj.
    

# **HATALI DURUMLAR VE YANITLAR**

Gerekli parametrelerden herhangi biri eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Gerekli alan(lar) eksik: 'id', 'title', 'due_date', 'is_done' ve 'category_id' alanları gerekli."
    

Kullanıcı, başka bir kullanıcıya ait bir görevi güncellemeye çalıştığında sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 403 (Forbidden)
    
- `message`: "Yetkisiz erişim: Bu todo'yu güncelleyemezsiniz."
    

Görev güncellenirken bir hata oluştuğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 500 (Internal Server Error)
    
- `message`: "Todo güncelleme başarısız: \[hata mesajı\]"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Token eksik"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Authorization başlığı eksik"
### Method: PUT
>```
>https://ahmettarikdemirci.io/todolist/edit_todo
>```
### Body (**raw**)

```json
{
  "id": "58B498AD-F2D8-4898-BEF6-B342849E4F40",
  "title": "Yeni değiştik ",
  "due_date": 1725070140,
  "is_done": false,
  "category_id":28
}
```

### 🔑 Authentication bearer

|Param|value|Type|
|---|---|---|
|token|eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FobWV0dGFyaWtkZW1pcmNpLmlvIiwiaWF0IjoxNzIyMjE2NzMxLCJleHAiOjEuMGUrNDUsInVzZXJfaWQiOjF9.cPWhNhyHQ93YhZK91oAjxPksrwJmKX_bYjVGYEIANHs|string|



⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Update Is Done
Bu istek, belirli bir görevin (todo) tamamlanma durumunu güncellemek için kullanılır. Görev kimliği (id) ve tamamlanma durumu (is_done) içeren bir JSON verisi gönderilir. Kullanıcı sadece kendi görevlerini güncelleyebilir ve güncelleme başarılı olursa, başarılı bir yanıt döner.

Bu istek, Bearer Token yetkilendirmesi gerektirir. Lütfen geçerli bir token ile istek gönderin.

Gönderilecek JSON verisi şu alanları içermelidir:

- `id`: Güncellenecek görevin benzersiz kimliği.
    
- `is_done`: Görevin tamamlanma durumu (0: tamamlanmamış, 1: tamamlanmış).
    

Başarılı bir istek sonucunda sunucu, görevin tamamlanma durumunun başarıyla güncellendiğini belirten bir JSON yanıtı döner. Yanıt şu alanları içerir:

- `success`: İsteğin başarılı olup olmadığını belirten bayrak (1: Başarılı, 0: Başarısız).
    
- `message`: İşlemle ilgili mesaj.
    

# **HATALI DURUMLAR VE YANITLAR**

Gerekli parametrelerden herhangi biri eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Gerekli alan(lar) eksik: 'id' ve 'is_done' alanları gerekli."
    

Kullanıcı, başka bir kullanıcıya ait bir görevi güncellemeye çalıştığında sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 403 (Forbidden)
    
- `message`: "Yetkisiz erişim: Bu todo'yu güncelleyemezsiniz."
    

Görev güncellenirken bir hata oluştuğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 500 (Internal Server Error)
    
- `message`: "Todo güncelleme başarısız: \[hata mesajı\]"
    

Geçersiz veya eksik token ile erişim yapılmaya çalışıldığında sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 401 (Unauthorized)
    
- `message`: "Yetkisiz erişim: \[hata mesajı\]"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Token eksik"
    

Authorization başlığı eksik olduğunda sunucu aşağıdaki yanıtı döner:

- HTTP Durum Kodu: 400 (Bad Request)
    
- `message`: "Authorization başlığı eksik"
### Method: PUT
>```
>https://ahmettarikdemirci.io/todolist/update_is_done
>```
### Body (**raw**)

```json
{
  "id": "487F9755-7C75-441C-AC10-45F30C9C14A5",
  "is_done": 1
}
```

### 🔑 Authentication bearer

|Param|value|Type|
|---|---|---|
|token|eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FobWV0dGFyaWtkZW1pcmNpLmlvIiwiaWF0IjoxNzIzMDUwMTgxLCJleHAiOjEuMGUrNDAsInVzZXJfaWQiOjI3fQ.tajJngcoxly5GliG25aFSDLoKaru73R9DhNEtYj1WOE|string|



⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃
_________________________________________________
Powered By: [postman-to-markdown](https://github.com/bautistaj/postman-to-markdown/)
