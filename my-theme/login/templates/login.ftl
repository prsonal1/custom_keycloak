<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        <div class="custom-header">
            <#-- Custom logo/background image -->
            <div class="custom-logo-container">
                <img src="${url.resourcesPath}/img/custom-image.png" 
                     alt="Custom Logo" 
                     class="custom-logo"
                     onerror="this.style.display='none'">
            </div>
        </div>
    <#elseif section = "form">
        <div class="custom-login-container">
            <div class="custom-login-form">
                <#if realm.password>
                    <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                        <div class="custom-form-group">
                            <#if !realm.loginWithEmailAllowed>
                                <div class="custom-input-container">
                                    <label for="username" class="custom-label">
                                        <#if !realm.loginWithEmailAllowed>
                                            ${msg("username")}
                                        <#elseif !realm.registrationEmailAsUsername>
                                            ${msg("usernameOrEmail")}
                                        <#else>
                                            ${msg("email")}
                                        </#if>
                                    </label>
                                    <input tabindex="1" id="username" class="custom-input" name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="off"
                                           aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                    />
                                    <#if messagesPerField.existsError('username','password')>
                                        <span id="input-error" class="custom-error" aria-live="polite">
                                            ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                        </span>
                                    </#if>
                                </div>
                            </#if>
                            
                            <#if realm.password>
                                <div class="custom-input-container">
                                    <label for="password" class="custom-label">${msg("password")}</label>
                                    <input tabindex="2" id="password" class="custom-input" name="password" type="password" autocomplete="off"
                                           aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                    />
                                </div>
                            </#if>
                        </div>

                        <div class="custom-form-options">
                            <#if realm.rememberMe && !usernameEditDisabled??>
                                <div class="custom-checkbox-container">
                                    <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" <#if login.rememberMe??>checked</#if>>
                                    <label for="rememberMe" class="custom-checkbox-label">${msg("rememberMe")}</label>
                                </div>
                            </#if>
                            
                            <#if realm.resetPasswordAllowed>
                                <div class="custom-forgot-password">
                                    <a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
                                </div>
                            </#if>
                        </div>

                        <div class="custom-form-actions">
                            <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                            <input tabindex="4" class="custom-button custom-button-primary" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                        </div>
                    </form>
                </#if>
            </div>
        </div>
    <#elseif section = "info">
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div class="custom-registration-info">
                <p>${msg("noAccount")} <a tabindex="6" href="${url.registrationUrl}">${msg("doRegister")}</a></p>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>