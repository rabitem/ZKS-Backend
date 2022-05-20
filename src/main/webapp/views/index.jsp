<!doctype html>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ACS - Access Control System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main_css.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.1/chart.js"
            integrity="sha512-Lii3WMtgA0C0qmmkdCpsG0Gjr6M0ajRyQRQSbTF6BsrVh/nhZdHpVZ76iMIPvQwz1eoXC3DmAg9K51qT5/dEVg=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js/dist/chart.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns/dist/chartjs-adapter-date-fns.bundle.min.js"></script>
</head>

<body>

<!-- Pop-Up Add User -->
<div class="cPopUpModal" id="popUpAddUser" data-remove="false">
    <div class="cPopUpContent">
        <div class="cPopUpHeader">
            <h1 id="hAddUser">Add User</h1>
            <span class="btnClose" id="btnCloseAddUser">&times;</span>
        </div>
        <p class="pResponseText" id="pAddUserResponse"></p>
        <form method="POST" id="addUserForm">

            <div class="cInputWrapper">
                <div class="cSingleInput">
                    <input type="text" id="iUserName" name="iUserName" required
                           onfocus="pInputOnFocus('iUserName', 'lUserNameLabel', 'cUserNameUnderline')"
                           onblur="pInputOnBlur('iUserName', 'lUserNameLabel', 'cUserNameUnderline')">
                    <div class="cInputUnderline" id="cUserNameUnderline"></div>
                    <label id="lUserNameLabel" for="iUserName">User Name</label>
                </div>
            </div>

            <div class="cInputWrapper">
                <div class="cSingleInput">
                    <div class="cDropdown" id="cDropdownAddUser">
                        <p class="pDropdownFirst" id="pUserRole" data-id="USER">USER</p>
                        <div class="cDropdownIcon"></div>
                        <div class="cDropdownContent" id="cDropdownContentAddUser">
                            <p class="dropdownItem" data-id="USER">USER</p>
                            <p class="dropdownItem" data-id="ADMIN">ADMIN</p>
                        </div>
                    </div>
                    <div class="cInputUnderline cDropdownLine"></div>
                    <label class = "lDropdownLabel">User Role</label>
                </div>
            </div>

            <div class="cInputWrapper" id="inputWrapperRFID">
                <div class="cSingleInput">
                    <input type="text" id="iUserRFID" name="iUserRFID" required
                           onfocus="pInputOnFocus('iUserRFID', 'lUserFIDLabel', 'cUserFIDUnderline')"
                           onblur="pInputOnBlur('iUserRFID', 'lUserFIDLabel', 'cUserFIDUnderline')">
                    <div class="cInputUnderline" id="cUserFIDUnderline"></div>
                    <label id="lUserFIDLabel" for="iUserRFID">User RFID</label>
                </div>
            </div>

            <input type="submit" id="button_Add_user" value="Add User">
        </form>
    </div>
</div>

<!-- Pop-Up Remove User -->
<div class="cPopUpModal" id="popUpRemoveUser" data-remove="false">
    <div class="cPopUpContent">
        <div class="cPopUpHeader">
            <h1>Remove User</h1>
            <span class="btnClose" id="btnCloseRemoveUser">&times;</span>
        </div>
        <p class="pResponseText" id="pRemoveUserResponse"></p>
        <form method="POST" id="removeUserForm">

            <div class="cInputWrapper">
                <div class="cSingleInput">
                    <div class="cDropdown" id="cDropdownRemUser">
                        <p class="pDropdownFirst" id="pRemoveUserDropFirst" data-id=""></p>
                        <div class="cDropdownIcon"></div>
                        <div class="cDropdownContent" id="cDropdownContentRemoveUser">
                        </div>
                    </div>
                    <div class="cInputUnderline cDropdownLine"></div>
                    <label class = "lDropdownLabel">User Name</label>
                </div>
            </div>

            <input type="submit" id="button_Remove_user" value="Remove User">
        </form>
    </div>
</div>

<!-- Pop-Up Add Location -->
<div class="cPopUpModal" id="popUpAddLocation" data-remove="false">
    <div class="cPopUpContent">
        <div class="cPopUpHeader">
            <h1 id="hAddLocation">Add Location</h1>
            <span class="btnClose" id="btnCloseAddLocation">&times;</span>
        </div>
        <p class="pResponseText" id="pAddLocationResponse"></p>
        <form method="POST" id="addLocationForm">

            <div class="cInputWrapper">
                <div class="cSingleInput">
                    <input type="text" id="iLocationName" name="iLocationName" required
                           onfocus="pInputOnFocus('iLocationName', 'lLocationNameLabel', 'cLocationNameUnderline')"
                           onblur="pInputOnBlur('iLocationName', 'lLocationNameLabel', 'cLocationNameUnderline')">
                    <div class="cInputUnderline" id="cLocationNameUnderline"></div>
                    <label id="lLocationNameLabel" for="iLocationName">Location Name</label>
                </div>
            </div>

            <div class="cInputWrapper">
                <div class="cSingleInput">
                    <input type="text" id="iLocationMACAdress" name="iLocationMACAdress" required
                                                                   onfocus="pInputOnFocus('iLocationMACAdress', 'lLocationMACAdressLabel', 'cLocationMACAdressUnderline')"
                                                                   onblur="pInputOnBlur('iLocationMACAdress', 'lLocationMACAdressLabel', 'cLocationMACAdressUnderline')">
                    <div class="cInputUnderline" id="cLocationMACAdressUnderline"></div>
                    <label id="lLocationMACAdressLabel" for="iLocationMACAdress">Location MACAdress</label>
                </div>
            </div>

            <input type="submit" id="button_Add_location" value = "Add Location">

        </form>
    </div>
</div>

<!-- Pop-Up Remove Location -->
<div class="cPopUpModal" id="popUpRemoveLocation" data-remove="false">
    <div class="cPopUpContent">
        <div class="cPopUpHeader">
            <h1 id="hRemoveLocation">Remove Location</h1>
            <span class="btnClose" id="btnCloseRemoveLocation">&times;</span>
        </div>
        <p class="pResponseText" id="pRemoveLocationResponse"></p>
        <form method="POST" id="removeLocationForm">

            <div class="cInputWrapper">
                <div class="cSingleInput">
                    <div class="cDropdown" id="cDropdownRemLocation">
                        <p class="pDropdownFirst" id="pRemoveLocationDropFirst" data-id=""></p>
                        <div class="cDropdownIcon"></div>
                        <div class="cDropdownContent" id="cDropdownContentRemoveLocation">
                        </div>
                        <div class="cInputUnderline cDropdownLine"></div>
                        <label class = "lDropdownLabel">Location Name</label>
                    </div>
                </div>
            </div>

            <input type="submit" id="button_Remove_location" value = "Remove Location">
        </form>
    </div>
</div>

<!-- Main Content -->
<div class="cGlobal">
    <div class="cSidebar">
        <nav class="navSidebar">
            <div class="cSidebarHeader">
                <h1 id="headerSidebar">Views</h1>
                <div class="cSidebarNavArrow">
                    <svg class="svgSidebarNavArrow" width="14" height="20" viewBox="0 0 14 20" fill="none"
                         xmlns="http://www.w3.org/2000/svg">
                        <path d="M11.8968 18.4384L2 10.2192L11.8968 2" stroke-width="2" stroke-linecap="round"
                              stroke-linejoin="round"></path>
                    </svg>
                </div>
            </div>
            <ul class="ulSidebar">
                <!-- Element 01: Administer Users -->
                <li class="ulSidebarItem ulSidebarItemActive">
                    <a href="#" id="navManageUsers">
                        <svg width="22" height="24" viewBox="0 0 22 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M21 23V20.6667C21 19.429 20.4732 18.242 19.5355 17.3668C18.5979 16.4917 17.3261 16 16 16H6C4.67392 16 3.40215 16.4917 2.46447 17.3668C1.52678 18.242 1 19.429 1 20.6667V23M16 6C16 8.76142 13.7614 11 11 11C8.23858 11 6 8.76142 6 6C6 3.23858 8.23858 1 11 1C13.7614 1 16 3.23858 16 6Z"
                                  stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path>
                        </svg>
                        <p>Manage Users</p>
                    </a>
                </li>
                <!-- Element 02: Administer Locations -->
                <li class="ulSidebarItem">
                    <a href="" id="navManageLocations">
                        <svg width="20" height="22" viewBox="0 0 20 22" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M7 21V11H13V21M1 8L10 1L19 8V19C19 19.5304 18.7893 20.0391 18.4142 20.4142C18.0391 20.7893 17.5304 21 17 21H3C2.46957 21 1.96086 20.7893 1.58579 20.4142C1.21071 20.0391 1 19.5304 1 19V8Z"
                                  stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path>
                        </svg>
                        <p>Manage Locations</p>
                    </a>
                </li>
                <!-- Element 03: Administer Access -->
                <li class="ulSidebarItem">
                    <a href="#" id="navManageAccess">
                        <svg width="20" height="18" viewBox="0 0 20 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M5 10V6C5 4.67392 5.52678 3.40215 6.46447 2.46447C7.40215 1.52678 8.67392 1 10 1C11.3261 1 12.5979 1.52678 13.5355 2.46447C14.4732 3.40215 15 4.67392 15 6V10M3 10H17C18.1046 10 19 10.8954 19 12V19C19 20.1046 18.1046 21 17 21H3C1.89543 21 1 20.1046 1 19V12C1 10.8954 1.89543 10 3 10Z"
                                  stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path>
                        </svg>
                        <p>Manage Access</p>
                    </a>
                </li>
                <!-- Element 04: Logs -->
                <li class="ulSidebarItem">
                    <a href="" id="navLogs">
                        <svg width="20" height="14" viewBox="0 0 20 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M15 5H1M19 1H1M19 9H1M15 13H1" stroke="white" stroke-width="2"
                                  stroke-linecap="round" stroke-linejoin="round"></path>
                        </svg>
                        <p>View Logs</p>
                    </a>
                </li>
                <!-- Element 05: Temperature -->
                <li class="ulSidebarItem">
                    <a href="" id="navTemparature">
                        <svg width="23" height="22" viewBox="0 0 23 22" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M17 8H18C19.0609 8 20.0783 8.42143 20.8284 9.17157C21.5786 9.92172 22 10.9391 22 12C22 13.0609 21.5786 14.0783 20.8284 14.8284C20.0783 15.5786 19.0609 16 18 16H17M17 8H1V17C1 18.0609 1.42143 19.0783 2.17157 19.8284C2.92172 20.5786 3.93913 21 5 21H13C14.0609 21 15.0783 20.5786 15.8284 19.8284C16.5786 19.0783 17 18.0609 17 17V8ZM5 1V4M9 1V4M13 1V4"
                                  stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path>
                        </svg>
                        <p>Temperature</p>
                    </a>
                </li>
                <!-- Element 05: Options  -->
                <%-- <li class="ulSidebarItem">
                    <a href="#">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12 15C13.6569 15 15 13.6569 15 12C15 10.3431 13.6569 9 12 9C10.3431 9 9 10.3431 9 12C9 13.6569 10.3431 15 12 15Z"
                                  stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M19.4 15C19.2669 15.3016 19.2272 15.6362 19.286 15.9606C19.3448 16.285 19.4995 16.5843 19.73 16.82L19.79 16.88C19.976 17.0657 20.1235 17.2863 20.2241 17.5291C20.3248 17.7719 20.3766 18.0322 20.3766 18.295C20.3766 18.5578 20.3248 18.8181 20.2241 19.0609C20.1235 19.3037 19.976 19.5243 19.79 19.71C19.6043 19.896 19.3837 20.0435 19.1409 20.1441C18.8981 20.2448 18.6378 20.2966 18.375 20.2966C18.1122 20.2966 17.8519 20.2448 17.6091 20.1441C17.3663 20.0435 17.1457 19.896 16.96 19.71L16.9 19.65C16.6643 19.4195 16.365 19.2648 16.0406 19.206C15.7162 19.1472 15.3816 19.1869 15.08 19.32C14.7842 19.4468 14.532 19.6572 14.3543 19.9255C14.1766 20.1938 14.0813 20.5082 14.08 20.83V21C14.08 21.5304 13.8693 22.0391 13.4942 22.4142C13.1191 22.7893 12.6104 23 12.08 23C11.5496 23 11.0409 22.7893 10.6658 22.4142C10.2907 22.0391 10.08 21.5304 10.08 21V20.91C10.0723 20.579 9.96512 20.258 9.77251 19.9887C9.5799 19.7194 9.31074 19.5143 9 19.4C8.69838 19.2669 8.36381 19.2272 8.03941 19.286C7.71502 19.3448 7.41568 19.4995 7.18 19.73L7.12 19.79C6.93425 19.976 6.71368 20.1235 6.47088 20.2241C6.22808 20.3248 5.96783 20.3766 5.705 20.3766C5.44217 20.3766 5.18192 20.3248 4.93912 20.2241C4.69632 20.1235 4.47575 19.976 4.29 19.79C4.10405 19.6043 3.95653 19.3837 3.85588 19.1409C3.75523 18.8981 3.70343 18.6378 3.70343 18.375C3.70343 18.1122 3.75523 17.8519 3.85588 17.6091C3.95653 17.3663 4.10405 17.1457 4.29 16.96L4.35 16.9C4.58054 16.6643 4.73519 16.365 4.794 16.0406C4.85282 15.7162 4.81312 15.3816 4.68 15.08C4.55324 14.7842 4.34276 14.532 4.07447 14.3543C3.80618 14.1766 3.49179 14.0813 3.17 14.08H3C2.46957 14.08 1.96086 13.8693 1.58579 13.4942C1.21071 13.1191 1 12.6104 1 12.08C1 11.5496 1.21071 11.0409 1.58579 10.6658C1.96086 10.2907 2.46957 10.08 3 10.08H3.09C3.42099 10.0723 3.742 9.96512 4.0113 9.77251C4.28059 9.5799 4.48572 9.31074 4.6 9C4.73312 8.69838 4.77282 8.36381 4.714 8.03941C4.65519 7.71502 4.50054 7.41568 4.27 7.18L4.21 7.12C4.02405 6.93425 3.87653 6.71368 3.77588 6.47088C3.67523 6.22808 3.62343 5.96783 3.62343 5.705C3.62343 5.44217 3.67523 5.18192 3.77588 4.93912C3.87653 4.69632 4.02405 4.47575 4.21 4.29C4.39575 4.10405 4.61632 3.95653 4.85912 3.85588C5.10192 3.75523 5.36217 3.70343 5.625 3.70343C5.88783 3.70343 6.14808 3.75523 6.39088 3.85588C6.63368 3.95653 6.85425 4.10405 7.04 4.29L7.1 4.35C7.33568 4.58054 7.63502 4.73519 7.95941 4.794C8.28381 4.85282 8.61838 4.81312 8.92 4.68H9C9.29577 4.55324 9.54802 4.34276 9.72569 4.07447C9.90337 3.80618 9.99872 3.49179 10 3.17V3C10 2.46957 10.2107 1.96086 10.5858 1.58579C10.9609 1.21071 11.4696 1 12 1C12.5304 1 13.0391 1.21071 13.4142 1.58579C13.7893 1.96086 14 2.46957 14 3V3.09C14.0013 3.41179 14.0966 3.72618 14.2743 3.99447C14.452 4.26276 14.7042 4.47324 15 4.6C15.3016 4.73312 15.6362 4.77282 15.9606 4.714C16.285 4.65519 16.5843 4.50054 16.82 4.27L16.88 4.21C17.0657 4.02405 17.2863 3.87653 17.5291 3.77588C17.7719 3.67523 18.0322 3.62343 18.295 3.62343C18.5578 3.62343 18.8181 3.67523 19.0609 3.77588C19.3037 3.87653 19.5243 4.02405 19.71 4.21C19.896 4.39575 20.0435 4.61632 20.1441 4.85912C20.2448 5.10192 20.2966 5.36217 20.2966 5.625C20.2966 5.88783 20.2448 6.14808 20.1441 6.39088C20.0435 6.63368 19.896 6.85425 19.71 7.04L19.65 7.1C19.4195 7.33568 19.2648 7.63502 19.206 7.95941C19.1472 8.28381 19.1869 8.61838 19.32 8.92V9C19.4468 9.29577 19.6572 9.54802 19.9255 9.72569C20.1938 9.90337 20.5082 9.99872 20.83 10H21C21.5304 10 22.0391 10.2107 22.4142 10.5858C22.7893 10.9609 23 11.4696 23 12C23 12.5304 22.7893 13.0391 22.4142 13.4142C22.0391 13.7893 21.5304 14 21 14H20.91C20.5882 14.0013 20.2738 14.0966 20.0055 14.2743C19.7372 14.452 19.5268 14.7042 19.4 15Z"
                                  stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <p>Settings</p>
                    </a>
                </li> --%>
            </ul>
        </nav>
    </div>
    <div class="cContentSection">
        <div class="cHeader">
            <svg id="pumpkin" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px"
                width="4rem" height="4rem" viewBox="0 0 864 864" xml:space="preserve">
                <g>
                    <path d="M840.541,537.2307c-5.5149-45.5801-18.0803-88.6279-37.3479-127.9487c-17.5037-35.7216-40.1042-67.6147-67.1726-94.7947
                        c-49.7932-49.9978-111.4966-79.8469-165.0613-79.8469c-11.8044,0.0005-23.0433,1.4712-33.4045,4.3705
                        c-7.1606,2.0038-13.7048,4.4749-19.696,7.4293c2.4407-13.6345-3.8721-22.5076-12.6965-32.3069
                        c5.6267-19.9182,17.0236-40.3489,35.2107-49.5431c2.634-1.3318,5.4891-2.4076,8.4702-3.2225
                        c-1.4409,18.3479,2.3542,37.522,13.3296,50.994c12.5396,15.3922,37.5564,20.2296,52.2729,4.6179
                        c12.4481-13.2054,10.0831-35.203,2.2908-50.0563c-7.9819-15.2146-22.5083-24.5098-38.6062-28.1841
                        c3.5155-6.6885,8.6067-12.3939,15.6254-16.1752c14.3029-7.7057,34.8082-7.1576,47.714,3.0936
                        c11.8051,9.3767,20.1217,23.0042,29.0383,34.9257c10.4298,13.9446,21.8003,28.7355,37.9244,36.4095
                        c19.6342,9.3447,40.0765,4.49,58.1249-6.1311c12.688-7.4667,1.1831-27.2607-11.5532-19.7656
                        c-17.4961,10.2961-33.5229,10.9928-48.6497-3.3618c-14.2628-13.5344-24.1362-30.9547-36.7095-45.9447
                        c-14.2783-17.0226-30.9067-26.6499-53.5504-27.0356c-25.8112-0.4398-49.2323,13.2202-59.9082,36.9576
                        c-0.8196,1.8224-1.5721,3.7173-2.27,5.6602c-31.5887,3.5088-54.3268,28.1147-66.0806,56.7507
                        c-5.7655-7.8352-11.0692-17.2539-14.5375-29.5135c-14.417-50.9613,18.1404-113.4598-60.0417-140.1578
                        C293.1809-16.5525,226.6708,149.5957,300.709,193.7102c53.304,31.7604,52.1724,9.6425,52.1724,9.6425
                        s-68.0801-49.0896-42.5311-102.9802c25.5491-53.8907,93.1537-44.5182,117.5328-2.7903s-1.3574,111.6439-40.8882,116.0394
                        c-13.814,1.5361-25.4194,6.7594-33.1572,14.126c-18.8071-4.2402-38.1323-6.3811-57.8743-6.3811
                        c-73.6007,0-142.7441,30.3965-194.6925,85.5896c-51.7054,54.9341-80.1808,127.9077-80.1808,205.4777
                        c0,84.1674,17.738,151.9891,52.7217,201.5818c35.3901,50.17,87.3367,79.7933,154.4065,88.0621
                        c28.8831,16.9827,65.2789,25.6296,108.2124,25.7004c11.2251,0,21.6924-2.4458,31.8774-7.4617
                        C394.7229,837.3608,426.6986,846,463.4158,846c35.9749,0,66.0265-13.1895,89.3196-39.2021
                        c2.3047-2.5737,4.6122-5.3872,6.8903-8.3999c11.2385,3.3879,22.776,5.1025,34.3644,5.1025c10.9625,0,21.9608-1.3853,32.717-4.1182
                        c11.3181,2.7329,22.9434,4.1182,34.5803,4.1182c45.6761,0,89.2917-20.8284,122.8108-58.6479
                        C829.7063,693.3936,850.2791,617.7183,840.541,537.2307z M572.0236,160.5048c7.6075,1.5314,14.6652,4.9611,19.8306,10.5746
                        c6.1857,6.7222,12.8451,22.6187,5.8109,30.5273c-1.337,1.5032-7.9944,2.9907-12.2659,1.0093
                        c-8.7092-4.04-11.8092-16.13-12.9807-24.6753C571.6539,172.3643,571.4741,166.4139,572.0236,160.5048z M43.0881,512.4337
                        c0-148.3652,113.4396-269.0692,252.8752-269.0692c16.1188,0,32.0327,1.6021,47.6318,4.7661
                        c-0.2205,3.1051,0.0791,6.3052,0.9558,9.5525c-38.3291,12.9131-76.7979,40.7258-110.1351,80.4756
                        c-46.5304,55.4806-77.7687,127.9343-85.704,198.7822c-12.416,110.8499,1.7832,187.865,43.4128,235.376
                        C69.6477,736.437,43.0881,612.8333,43.0881,512.4337z M347.1589,804.6221c-0.3005,0.0732-0.6006,0.1489-0.9049,0.2097
                        c-0.3131,0.0623-0.6328,0.1106-0.9531,0.1602l-1.2676,0.2097c-0.3024,0.0537-0.6049,0.1091-0.9111,0.1497
                        c-0.3376,0.0444-0.683,0.0728-1.0278,0.1033l-1.3096,0.1287c-0.3,0.033-0.6005,0.0676-0.9111,0.0874
                        c-0.3396,0.0222-0.6869,0.0281-1.0345,0.0356l-1.3849,0.0454c-0.3014,0.0129-0.6024,0.0283-0.9974,0.0283
                        c-14.4235-0.0242-28.094-1.0693-40.6313-3.1067c-8.1433-1.3235-15.9983-3.0967-23.3462-5.2695
                        c-1.8123-0.5364-3.6257-1.106-5.3901-1.6936c-3.4989-1.1658-6.9514-2.4517-10.2622-3.8215
                        c-1.6382-0.6777-3.2795-1.3921-4.877-2.1223c-3.1699-1.45-6.2864-3.0173-9.2639-4.6599c-2.949-1.626-5.8512-3.3738-8.6256-5.1958
                        c-2.7435-1.8013-5.4403-3.7266-8.0145-5.7209c-2.5497-1.9761-5.0482-4.0732-7.4257-6.2332
                        c-4.6932-4.2634-9.1249-8.9619-13.1732-13.9644c-1.0051-1.2424-2.0002-2.519-2.9578-3.7969
                        c-7.5457-10.061-13.9868-21.7014-19.145-34.5988c-1.2622-3.1549-2.47-6.4425-3.5909-9.7716
                        c-1.1089-3.2944-2.1642-6.7244-3.1361-10.1943c-2.3857-8.5156-4.3811-17.6772-5.9319-27.23
                        c-0.6096-3.7607-1.1619-7.6455-1.6404-11.5468c-4.0913-33.3312-3.5916-71.7538,1.5281-117.4642
                        c13.5906-121.3403,98.7224-236.8293,186.0508-262.5674c1.5337,1.4966,3.2041,2.9833,5.0327,4.4539
                        c3.2712,2.6306,6.6027,4.7225,9.9554,6.3606c-13.6022,14.256-26.0616,33.498-37.099,57.3398
                        c-22.5856,48.7842-39.2764,116.6475-48.2687,196.2533c-5.9227,52.4283-5.2184,99.9635,2.0939,141.2836
                        c8.2561,46.6543,24.8182,84.1619,49.2256,111.4812c3.2644,3.6548,6.7007,7.1526,10.2767,10.4639L347.1589,804.6221z
                        M539.459,788.4937v-0.0005c-1.7113,2.084-3.4974,4.106-5.3081,6.0098c-1.8131,1.9063-3.7014,3.7468-5.6125,5.4707
                        c-1.9177,1.7297-3.9089,3.3875-5.9177,4.9272c-2.0172,1.5464-4.1125,3.0193-6.2275,4.3792
                        c-2.1262,1.3674-4.3276,2.6548-6.5425,3.8279c-13.6521,7.2288-29.2751,10.894-46.4348,10.894
                        c-24.8743,0-47.2389-4.3936-66.4722-13.0583c-3.0813-1.3882-6.1267-2.906-9.052-4.5115c-1.449-0.7949-2.9043-1.6306-4.3242-2.4844
                        c-0.8938-0.5374-1.7673-1.0979-2.6414-1.6575l-0.3193-0.2039c-2.072-1.3257-3.7549-2.4551-5.2965-3.5559
                        c-2.6417-1.8855-5.2489-3.9041-7.7488-5.9988c-1.244-1.043-2.485-2.1233-3.6885-3.2129c-2.3949-2.1682-4.7544-4.4707-7.0123-6.843
                        c-2.2408-2.3552-4.4403-4.8406-6.5371-7.3865c-2.0865-2.5342-4.1288-5.1968-6.0712-7.9148
                        c-1.4688-2.0547-2.9838-4.3115-4.6315-6.8994c-2.7223-4.2749-5.3235-8.8147-7.7324-13.4939
                        c-1.238-2.4043-2.2327-4.4197-3.1318-6.3428c-0.7466-1.5969-1.4851-3.2341-2.1946-4.8667
                        c-12.4285-28.5898-19.7363-63.6366-21.7217-104.1652c-0.2026-4.1418-0.3506-8.3763-0.4409-12.5862
                        c-0.0945-4.4432-0.1287-8.9657-0.1012-13.4403c0.1201-19.6438,1.4003-40.3965,3.8047-61.6816
                        c1.842-16.3054,4.0511-32.3601,6.5665-47.7178c0.3618-2.2102,0.7307-4.4092,1.1064-6.599
                        c1.1273-6.5656,2.3284-13.1003,3.5698-19.4232c1.2546-6.3853,2.5806-12.7166,3.9426-18.8191
                        c0.9131-4.0935,1.8662-8.1915,2.8323-12.1804c0.4854-2.0037,0.9773-3.9949,1.4775-5.9739
                        c0.9974-3.9541,2.0315-7.8925,3.075-11.7053c2.1029-7.6934,4.3328-15.2227,6.6272-22.3787
                        c1.1597-3.6157,2.3539-7.1951,3.5496-10.6389c1.2107-3.4855,2.4565-6.9332,3.7043-10.2483
                        c1.259-3.3456,2.5559-6.6558,3.8569-9.8403c1.3062-3.1997,2.6538-6.3668,4.0057-9.4133
                        c10.6029-23.895,26.1661-50.8026,46.939-66.4681c15.1053-1.569,28.2618-8.7208,35.319-13.2881
                        c0.5313-0.0153,1.0636-0.027,1.5992-0.027c4.1688,0,8.3472,0.5459,12.5211,1.5884c4.0067,2.1519,9.1606,4.4524,14.9187,5.9216
                        c21.5527,11.7256,42.521,36.9373,60.8929,73.824c25.6035,51.4067,44.2623,120.9009,52.5393,195.6814
                        c1.0948,9.8927,1.9844,19.7402,2.6437,29.2698c0.3285,4.7423,0.6068,9.517,0.8278,14.1919
                        c0.4393,9.3164,0.6632,18.5454,0.6647,27.432c0.0005,2.2303-0.0131,4.4471-0.04,6.65
                        c-0.2721,22.0073-1.9362,42.6865-4.9464,61.4636c-0.9044,5.6404-1.9438,11.1917-3.0905,16.4998
                        C566.225,743.8254,554.8707,769.73,539.459,788.4937z M593.99,781.5024c-7.3018,0-14.6039-0.8499-21.799-2.5332
                        c28.212-51.3604,37.4879-129.0071,26.8195-225.3967c-8.5542-77.2877-27.9849-149.4053-54.7126-203.0688
                        c-14.3511-28.8135-30.168-51.2178-47.1926-66.8914c85.7729,10.5762,183.2129,82.5273,220.3274,258.1704
                        c6.6338,31.3944,8.8374,61.4707,6.5508,89.3938c-0.3103,3.7806-0.708,7.5732-1.1833,11.2719
                        c-0.7017,5.4673-1.5955,10.9066-2.656,16.1671c-0.6973,3.4602-1.4819,6.9167-2.3323,10.2747
                        c-1.2585,4.9716-2.703,9.8977-4.2932,14.641c-5.6694,16.9027-13.3956,32.2006-22.9639,45.4696
                        c-1.6848,2.3367-3.4463,4.6355-5.2352,6.8323C661.3361,765.2832,628.9011,781.5024,593.99,781.5024z M767.636,730.2612
                        c-27.7012,31.2546-62.9906,49.2275-99.9812,51.0815c12.8683-8.4236,24.5684-19.0952,34.9479-31.897
                        c19.4686-24.0129,33.2003-54.9916,39.7106-89.5869c7.0493-37.4614,5.9197-78.7183-3.3582-122.6243
                        c-20.0996-95.123-58.1364-168.0293-113.0541-216.6929c-29.5463-26.1814-63.705-44.5625-99.577-53.7019
                        c5.1108-2.6653,10.802-4.8662,17.1587-6.6451c8.4319-2.3596,17.6768-3.5558,27.4775-3.5563
                        c47.8384-0.002,103.715,27.4248,149.4712,73.3667c37.8445,37.9983,85.6133,105.2528,98.2703,209.8679
                        C827.6843,614.1157,809.0718,683.5094,767.636,730.2612z"></path>
                    <g>
                        <path fill="#e9676e" d="M576.2958,694.9998c3.0103-18.7771,4.6743-39.4563,4.9464-61.4636c0.027-2.2029,0.0405-4.4197,0.04-6.65
                            c-0.0015-8.8866-0.2253-18.1156-0.6647-27.432c-0.2209-4.6749-0.4993-9.4496-0.8278-14.1919
                            c-0.6593-9.5295-1.5488-19.3771-2.6437-29.2698c-8.277-74.7805-26.9358-144.2747-52.5393-195.6814
                            c-18.3719-36.8867-39.3402-62.0984-60.8929-73.824c-5.7581-1.4692-10.912-3.7698-14.9187-5.9216
                            c-4.174-1.0425-8.3523-1.5884-12.5211-1.5884c-0.5356,0-1.068,0.0117-1.5992,0.027c-7.0571,4.5673-20.2136,11.7191-35.319,13.2881
                            c-20.7728,15.6655-36.3361,42.5731-46.939,66.4681c-1.3519,3.0465-2.6996,6.2136-4.0057,9.4133
                            c-1.301,3.1846-2.5979,6.4948-3.8569,9.8403c-1.2478,3.3151-2.4937,6.7628-3.7043,10.2483
                            c-1.1957,3.4438-2.3899,7.0232-3.5496,10.6389c-2.2944,7.156-4.5243,14.6853-6.6272,22.3787
                            c-1.0435,3.8129-2.0775,7.7512-3.075,11.7053c-0.5002,1.979-0.9922,3.9702-1.4775,5.9739
                            c-0.9661,3.9889-1.9192,8.0869-2.8323,12.1804c-1.3621,6.1025-2.688,12.4338-3.9426,18.8191
                            c-1.2415,6.3229-2.4425,12.8577-3.5698,19.4232c-0.3757,2.1898-0.7446,4.3888-1.1064,6.599
                            c-2.5154,15.3577-4.7245,31.4124-6.5665,47.7178c-2.4044,21.2852-3.6846,42.0378-3.8047,61.6816
                            c-0.0275,4.4746,0.0067,8.9971,0.1012,13.4403c0.0903,4.2098,0.2383,8.4443,0.4409,12.5862
                            c1.9854,40.5286,9.2932,75.5753,21.7217,104.1652c0.7095,1.6326,1.448,3.2698,2.1946,4.8667
                            c0.8992,1.9231,1.8938,3.9385,3.1318,6.3428c2.4089,4.6792,5.0101,9.219,7.7324,13.4939
                            c1.6477,2.5879,3.1627,4.8447,4.6315,6.8994c1.9424,2.718,3.9846,5.3806,6.0712,7.9148c2.0968,2.5459,4.2963,5.0313,6.5371,7.3865
                            c2.2579,2.3723,4.6174,4.6748,7.0123,6.843c1.2035,1.0896,2.4445,2.1699,3.6885,3.2129c2.4999,2.0947,5.1071,4.1133,7.7488,5.9988
                            c1.5416,1.1008,3.2245,2.2302,5.2965,3.5559l0.3193,0.2039c0.874,0.5596,1.7476,1.1201,2.6414,1.6575
                            c1.4199,0.8538,2.8752,1.6895,4.3242,2.4844c2.9253,1.6055,5.9707,3.1233,9.052,4.5115
                            c19.2333,8.6648,41.5979,13.0583,66.4722,13.0583c17.1597,0,32.7827-3.6653,46.4348-10.894
                            c2.2148-1.1731,4.4163-2.4604,6.5425-3.8279c2.115-1.3599,4.2103-2.8328,6.2275-4.3792c2.0088-1.5398,4-3.1975,5.9177-4.9272
                            c1.9111-1.7239,3.7994-3.5645,5.6125-5.4707c1.8107-1.9038,3.5968-3.9258,5.3081-6.0098v0.0005
                            c15.4117-18.7637,26.766-44.6682,33.7463-76.9941C574.3519,706.1914,575.3914,700.6401,576.2958,694.9998z"></path>
                        <path fill="#e9676e" d="M337.5637,793.9946c-24.4073-27.3193-40.9695-64.8269-49.2256-111.4812
                            c-7.3123-41.3201-8.0166-88.8552-2.0939-141.2836c8.9923-79.6058,25.6831-147.4691,48.2687-196.2533
                            c11.0374-23.8418,23.4968-43.0839,37.099-57.3398c-3.3528-1.6381-6.6842-3.73-9.9554-6.3606
                            c-1.8286-1.4706-3.499-2.9573-5.0327-4.4539c-87.3284,25.738-172.4602,141.2271-186.0508,262.5674
                            c-5.1196,45.7104-5.6194,84.1331-1.5281,117.4642c0.4785,3.9012,1.0308,7.786,1.6404,11.5468
                            c1.5508,9.5527,3.5461,18.7144,5.9319,27.23c0.9719,3.47,2.0272,6.8999,3.1361,10.1943c1.121,3.3291,2.3287,6.6167,3.5909,9.7716
                            c5.1582,12.8973,11.5994,24.5377,19.145,34.5988c0.9575,1.2778,1.9526,2.5544,2.9578,3.7969
                            c4.0483,5.0024,8.48,9.7009,13.1732,13.9644c2.3774,2.1599,4.876,4.2571,7.4257,6.2332c2.5742,1.9944,5.271,3.9197,8.0145,5.7209
                            c2.7744,1.822,5.6766,3.5698,8.6256,5.1958c2.9775,1.6426,6.094,3.21,9.2639,4.6599c1.5974,0.7302,3.2388,1.4446,4.877,2.1223
                            c3.3108,1.3699,6.7633,2.6558,10.2622,3.8215c1.7644,0.5876,3.5779,1.1572,5.3901,1.6936
                            c7.3479,2.1729,15.2029,3.946,23.3462,5.2695c12.5374,2.0374,26.2079,3.0825,40.6313,3.1067c0.395,0,0.696-0.0154,0.9974-0.0283
                            l1.3849-0.0454c0.3477-0.0076,0.6949-0.0134,1.0345-0.0356c0.3107-0.0198,0.6111-0.0544,0.9111-0.0874l1.3096-0.1287
                            c0.3448-0.0305,0.6902-0.0588,1.0278-0.1033c0.3063-0.0405,0.6088-0.0959,0.9111-0.1497l1.2676-0.2097
                            c0.3203-0.0496,0.64-0.0979,0.9531-0.1602c0.3043-0.0608,0.6044-0.1365,0.9049-0.2097l0.6815-0.1636
                            C344.2644,801.1472,340.8281,797.6494,337.5637,793.9946z"></path>
                        <path fill="#e9676e" d="M148.7119,536.9409c7.9353-70.8479,39.1736-143.3016,85.704-198.7822
                            c33.3373-39.7498,71.806-67.5625,110.1351-80.4756c-0.8767-3.2473-1.1763-6.4474-0.9558-9.5525
                            c-15.5991-3.1641-31.5131-4.7661-47.6318-4.7661c-139.4357,0-252.8752,120.704-252.8752,269.0692
                            c0,100.3995,26.5596,224.0033,149.0366,259.8832C150.4951,724.8059,136.2959,647.7908,148.7119,536.9409z"></path>
                        <path fill="#e9676e" d="M720.4314,330.0051c-45.7562-45.9419-101.6328-73.3687-149.4712-73.3667
                            c-9.8008,0.0005-19.0457,1.1967-27.4775,3.5563c-6.3567,1.7789-12.0479,3.9799-17.1587,6.6451
                            c35.8721,9.1394,70.0308,27.5205,99.577,53.7019c54.9177,48.6636,92.9545,121.5698,113.0541,216.6929
                            c9.2778,43.906,10.4075,85.1628,3.3582,122.6243c-6.5103,34.5953-20.2419,65.574-39.7106,89.5869
                            c-10.3795,12.8018-22.0796,23.4734-34.9479,31.897c36.9906-1.854,72.28-19.8269,99.9812-51.0815
                            c41.4358-46.7518,60.0483-116.1455,51.0657-190.3882C806.0447,435.2579,758.2759,368.0034,720.4314,330.0051z"></path>
                        <path fill="#e9676e" d="M685.3195,735.833c1.7889-2.1968,3.5504-4.4956,5.2352-6.8323
                            c9.5682-13.269,17.2944-28.5669,22.9639-45.4696c1.5902-4.7433,3.0347-9.6694,4.2932-14.641
                            c0.8503-3.3579,1.635-6.8145,2.3323-10.2747c1.0605-5.2605,1.9543-10.6998,2.656-16.1671
                            c0.4753-3.6986,0.873-7.4912,1.1833-11.2719c2.2866-27.9231,0.083-57.9994-6.5508-89.3938
                            c-37.1145-175.6431-134.5544-247.5942-220.3274-258.1704c17.0247,15.6736,32.8416,38.0779,47.1926,66.8914
                            c26.7278,53.6636,46.1584,125.7811,54.7126,203.0688c10.6685,96.3896,1.3926,174.0364-26.8195,225.3967
                            c7.1951,1.6833,14.4972,2.5332,21.799,2.5332C628.9011,781.5024,661.3361,765.2832,685.3195,735.833z"></path>
                    </g>
                </g>
            </svg>
            <h1 id="hCorpName">Pumpkin Intl.</h1>
            <h1 id="hCurView"> - Manage Users</h1>
        </div>
        <div class="cMainContent">
            <!-- Global Spinning Bar -->
            <div class="cSpinnerLoading" id="spinnerMainContent"></div>
            <!--Pages Content is inserted here-->
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/navigation_ui.js"></script>
<script src="${pageContext.request.contextPath}/js/navigation_ajax.js"></script>
<script src="${pageContext.request.contextPath}/js/forms_ajax.js"></script>

</body>
</html>