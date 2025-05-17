EntraCP enhances SharePoint's integration with Microsoft Entra ID by resolving limitations in user/group management. Here's its role and authentication flow:

---

### **Role of EntraCP**
1. **Claims Provider**  
   Acts as a bridge between SharePoint and Microsoft Entra ID to resolve user/group identities during authorization .

2. **People Picker Enhancement**  
   Enables SharePoint to search and validate users/groups directly against Microsoft Entra ID (instead of requiring manual UPN/GUID entry) .

3. **Guest User Support**  
   Simplifies management of B2B and MSA guest accounts by ensuring consistent claims mapping .

---

### **Authentication & Authorization Flow**  
```text
[User Access]  
│  
├─1. User requests access to SharePoint site  
│  
├─2. SharePoint redirects to Microsoft Entra ID  
│    (SAML authentication request)  
│  
├─3. Microsoft Entra ID authenticates user  
│    │  
│    ├─ Member User: Direct authentication  
│    └─ Guest User: B2B/Google/MSA federation  
│  
├─4. Microsoft Entra ID issues SAML token  
│    (Contains claims: UPN, groups, roles)  
│  
├─5. SharePoint validates SAML token  
│    (Uses EntraID-trusted certificate [1])  
│  
├─6. Authorization Phase:  
│    │  
│    ├─a. Without EntraCP:  
│    │     - Users must manually type exact UPNs/GUIDs  
│    │  
│    └─b. With EntraCP:  
│         │  
│         ├─i. SharePoint queries EntraCP  
│         │  
│         ├─ii. EntraCP connects to Microsoft Entra Graph API  
│         │      (Searches users/groups in real-time)  
│         │  
│         └─iii. Returns resolved identities to SharePoint  
│  
└─7. SharePoint grants access based on permissions  
     (Assigned via EntraCP-resolved users/groups)  
```

---

### **Key Interactions**  
| Component                | Function                                  | Source |  
|--------------------------|-------------------------------------------|--------|  
| **EntraCP**              | Resolves fuzzy user/group inputs         | [2]    |  
| **Microsoft Entra ID**   | Issues SAML tokens & manages identities  | [1]    |  
| **SharePoint**           | Validates tokens & enforces permissions  | [1]    |  

This flow ensures seamless authentication while eliminating manual identity entry errors in SharePoint .

Citations:
[1] https://learn.microsoft.com/en-us/entra/identity/saas-apps/sharepoint-on-premises-tutorial
[2] https://entracp.yvand.net/overview/introduction/

---
Answer from Perplexity: pplx.ai/share

To configure federated authentication for **15 SharePoint sites** with different Reply URLs (Assertion Consumer Service URLs) using Microsoft Entra ID, you **do not need to create 15 separate enterprise applications**. Here's the streamlined approach:

---

### **Single Enterprise Application Configuration**
1. **Add All Reply URLs to One App**  
   In the existing enterprise application (e.g., `SharePoint corporate farm`), navigate to **Single sign-on > SAML Configuration** and add all 15 Reply URLs (e.g., `https://site1.company.com/_trust/`, `https://site2.company.com/_trust/`, etc.) under **Reply URL (Assertion Consumer Service URL)** [1][4][5].

2. **Configure SharePoint to Pass `WReply`**  
   On each SharePoint server, run this PowerShell command to ensure SharePoint includes the SAML `WReply` parameter in authentication requests:  
   ```powershell
   $t = Get-SPTrustedIdentityTokenIssuer "MicrosoftEntraTrust"
   $t.UseWReplyParameter = $true
   $t.Update()
   ```
   This ensures the SAML token is sent to the correct Reply URL for each site [1][4].

3. **Verify Alternate Access Mappings**  
   Ensure each SharePoint site’s URL is listed in **Alternate Access Mappings** with the correct zone (e.g., Internet) [1][2].

---

### **When to Use Multiple Enterprise Apps**
Create separate enterprise applications **only if**:  
- Sites require **different SAML configurations** (e.g., unique claims, certificates, or authentication rules) [6].  
- You need to enforce **distinct access policies** (e.g., conditional access rules) per site [6].

---

### **Key Considerations**
- **Token Routing**: The SAML token is sent to the Reply URL specified in the authentication request, even if multiple URLs are configured [3][5].  
- **Limits**: A single enterprise app supports up to **256 Reply URLs** [5].  
- **Maintenance**: A single app simplifies management but requires consistent settings across all sites [1][4].

---

### **Example Workflow for Multiple Sites**
1. **Enterprise App Setup**:  
   ![](https://learn.microsoft.com/en-us/entra/identity/saas-apps/sharepoint-on-premises  
     
   Add all Reply URLs under **Basic SAML Configuration** [1][4].

2. **SharePoint Configuration**:  
   Extend each web application to use the same trusted identity provider (`MicrosoftEntraTrust`) and ensure `UseWReplyParameter = $true` [1][4].

---

This approach minimizes overhead while ensuring seamless authentication across all 15 sites.

Citations:
[1] https://learn.microsoft.com/en-us/entra/identity/saas-apps/sharepoint-on-premises-tutorial
[2] https://learn.microsoft.com/en-us/answers/questions/735735/is-there-any-option-to-get-saml-response-for-multi
[3] https://sharepointwhoknew.wordpress.com/2019/02/01/sharepointazuressoapps/
[4] https://learn.microsoft.com/en-us/answers/questions/978948/saml-multiple-reply-url
[5] https://learn.microsoft.com/en-us/answers/questions/2113584/how-can-i-have-multiple-acs-urls-on-a-single-saml
[6] https://learn.microsoft.com/en-us/troubleshoot/entra/entra-id/app-integration/reply-url-redirected-to-localhost
[7] https://sharepoint.stackexchange.com/questions/34274/same-public-url-on-two-zones
[8] https://learn.microsoft.com/en-us/entra/identity-platform/reply-url
[9] https://learn.microsoft.com/en-us/answers/questions/1183042/add-multple-url-in-azure-sso-in-enterprise-applica
[10] https://stackoverflow.com/questions/76595193/can-i-set-two-different-redirect-url-reply-url-inside-a-spa-application-inside

---
Answer from Perplexity: pplx.ai/share
