<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>

<div class="cMainContentManageUsers" id="cMainContentSubFolder">
    <jsp:useBean id="locations" scope="request" type="java.util.List"/>
    <jsp:useBean id="users" scope="request" type="java.util.List"/>
    <jsp:useBean id="authorizations" scope="request" type="java.util.List"/>

    <!-- Pop-Up Add Authorization -->
    <div class="cPopUpModal" id="popUpAddAuthorization" data-remove="false">
        <div class="cPopUpContent">
            <div class="cPopUpHeader">
                <h1 id="hManageAuthorization">Grant Access</h1>
                <span class="btnClose" id="btnCloseManageAuthorization">&times;</span>
            </div>
            <p class="pResponseText" id="pAddAuthorizationResponse"></p>

            <form method="POST" id="addAuthorizationForm">

                <div class="cInputWrapper">
                    <div class="cSingleInput">
                        <div class="cDropdown" id="cDropdownAuthLocation">
                            <p class="pDropdownFirst" id="pAddAuthorizationLocationDropdownFirst" data-id="${locations.get(0).id}">${locations.get(0).label}
                                (${locations.get(0).id})</p>
                            <div class="cDropdownIcon"></div>
                            <div class="cDropdownContent" id="cDropdownContentAddAuthorizationLocation">
                                <c:forEach items="${locations}" var="location">
                                    <p class="dropdownItem" data-id="${location.id}">${location.label} (${location.id})</p>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="cInputUnderline"></div>
                        <label class = "lDropdownLabel">Location Name</label>
                    </div>
                </div>

                <div class="cInputWrapper">
                    <div class="cSingleInput">
                        <div class="cDropdown" id="cDropdownAuthUser">
                            <p class="pDropdownFirst" id="pAddAuthorizationDropdownFirst" data-id="${users.get(0).id}">${users.get(0).name}
                                (${users.get(0).id})</p>
                            <div class="cDropdownIcon"></div>
                            <div class="cDropdownContent" id="cDropdownContentAddAuthorization">
                                <c:forEach items="${users}" var="user">
                                    <p class="dropdownItem" data-id="${user.id}">${user.name} (${user.id})</p>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="cInputUnderline"></div>
                        <label class = "lDropdownLabel">User Name</label>
                    </div>
                </div>               

                <input type="submit" id="button_manage_Authorization" value = "Grant Access">
            </form>
        </div>
    </div>

    <!-- Pop-Up Remove Authorization -->
    <div class="cPopUpModal" id="popUpRemoveAuthorization" data-remove="false">
        <div class="cPopUpContent">
            <div class="cPopUpHeader">
                <h1 id="hRemoveAuthorization">Revoke Access</h1>
                <span class="btnClose" id="btnCloseRemoveAuthorization">&times;</span>
            </div>
            <p class="pResponseText" id="pRemoveAuthorizationResponse"></p>

            <form method="POST" id="removeAuthorizationForm">

                <div class="cInputWrapper">
                    <div class="cSingleInput">
                        <div class="cDropdown" id="cDropdownAuthorizations">
                            <p class="pDropdownFirst" id="pRemoveAuthorizationLocationDropdownFirst" data-id="${authorizations.get(0).id}">
                                User ${authorizations.get(0).user.name} to Location ${authorizations.get(0).location.label}</p>
                            </p>
                            <div class="cDropdownIcon"></div>
                            <div class="cDropdownContent" id="cDropdownContentRemoveAuthorizationLocation">
                                <c:forEach items="${authorizations}" var="authorization">
                                    <p class="dropdownItem" data-id="${authorization.id}">
                                        User <em>${authorization.user.name}</em> to Location <em>${authorization.location.label}</em>
                                    </p>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="cInputUnderline"></div>
                        <label>Revoke Authorizations</label>
                    </div>
                </div>

                <input type="submit" id="button_remove_Authorization" value = "Revoke Access">
            </form>
        </div>
    </div>

    <div class="cAdjustments cMainBox">
        <h2>Manage User Location Authorization</h2>
        <div class="cOptions">
            <p class = "svgBtnDescription">Grant Access</p>
            <svg class="svgAdd" id="svgAddSignAuthorization" width="21" height="21" viewBox="0 0 21 21" fill="none"
                 xmlns="http://www.w3.org/2000/svg">
                <path d="M10 6V14M6 10H14M3 1H17C18.1046 1 19 1.89543 19 3V17C19 18.1046 18.1046 19 17 19H3C1.89543 19 1 18.1046 1 17V3C1 1.89543 1.89543 1 3 1Z"
                      stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            <p class = "svgBtnDescription">Revoke Access</p>
            <svg class="svgRemove" id="svgRemoveSignAuthorization" width="21" height="21" viewBox="0 0 21 21"
                 fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M7.50562 7.69464L13.5056 13.6946M13.5056 7.69464L7.50562 13.6946M3.50562 1.69464H17.5056C18.6102 1.69464 19.5056 2.59007 19.5056 3.69464V17.6946C19.5056 18.7992 18.6102 19.6946 17.5056 19.6946H3.50562C2.40105 19.6946 1.50562 18.7992 1.50562 17.6946V3.69464C1.50562 2.59007 2.40105 1.69464 3.50562 1.69464Z"
                      stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </div>
    </div>
    <div class="cTableContent cMainBox">
        <h2>Current Authorizations</h2>
        <table>
            <tr>
                <th>User Name</th>
                <th>User Role</th>
                <th>Location Name</th>
                <th>Location MAC-Address</th>
            </tr>
            <!-- Generated JSP Content -->
            <c:forEach items="${authorizations}" var="authObj">
                <tr class="trCurData" id="trData${authObj.user.name}${authObj.location.label}"
                    data-valueID="${authObj.id}">
                    <td class="trCurData" id="trData${authObj.user.name}"
                        data-valueID="${authObj.user.id}">${authObj.user.name}</td>
                    <td>${authObj.user.role.label}</td>
                    <td class="trCurData" id="trData${authObj.location.label}"
                        data-valueID="${authObj.location.id}">${authObj.location.label}</td>
                    <td>${authObj.location.macAddress}</td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <script src="${pageContext.request.contextPath}/js/forms_ajax.js"></script>
</div>