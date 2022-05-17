<!doctype html>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ACS - Access Control System</title>
    <link rel="stylesheet" href="/css/main_css.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>

<!-- Pop_ups -->
<div class = "cPopUpModal" id = "popUpManageUser">
    <div class = "cPopUpContent">
        <div class="cPopUpHeader">
            <h1>Manage User</h1>
            <span class="btnClose" id = "btnCloseManageUser">&times;</span>
        </div>

        <form method="POST" id="updateUserForm">

            <div class="cInputWrapper">
                <div class="cSingleInput">
                    <input type="text"  id="iUserName" name="iUserName" required
                           onfocus="pInputOnFocus('iUserName', 'lUserNameLabel', 'cUserNameUnderline')"
                           onblur="pInputOnBlur('iUserName', 'lUserNameLabel', 'cUserNameUnderline')">
                    <div class="cInputUnderline" id="cUserNameUnderline"></div>
                    <label id="lUserNameLabel">User Name</label>
                </div>
            </div>

            <div class="cInputWrapper">
                <div class="cSingleInput">
                    <input type="text"  id="iUserRole" name="iUserRole" required
                           onfocus="pInputOnFocus('iUserRole', 'lUserRoleLabel', 'cUserRoleUnderline')"
                           onblur="pInputOnBlur('iUserRole', 'lUserRoleLabel', 'cUserRoleUnderline')">
                    <div class="cInputUnderline" id="cUserRoleUnderline"></div>
                    <label id="lUserRoleLabel">User Role</label>
                </div>
            </div>

            <div class="cInputWrapper">
                <div class="cSingleInput">
                    <input type="text"  id="iUserFID" name="iUserFID" required
                           onfocus="pInputOnFocus('iUserFID', 'lUserFIDLabel', 'cUserFIDUnderline')"
                           onblur="pInputOnBlur('iUserFID', 'lUserFIDLabel', 'cUserFIDUnderline')">
                    <div class="cInputUnderline" id="cUserFIDUnderline"></div>
                    <label id="lUserFIDLabel">User RFID</label>
                </div>
            </div>

            <input type="submit" id="button_manage_user" value="Add User">
        </form>
    </div>
</div>

<!-- Main Content -->
<div class="cGlobal">
    <div class = "cSidebar">
        <nav class = "navSidebar">
            <div class="cSidebarHeader">
                <h1 id = "headerSidebar">Views</h1>
                <div class="cSidebarNavArrow">
                    <svg class = "svgSidebarNavArrow" width="14" height="20" viewBox="0 0 14 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M11.8968 18.4384L2 10.2192L11.8968 2" stroke-width="2";  stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
            </div>
            <ul class = "ulSidebar">
                <!-- Element 01: Administer Users -->
                <li class="ulSidebarItem ulSidebarItemActive">
                    <a href = "#" id = "navManageUsers">
                        <svg width="22" height="24" viewBox="0 0 22 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M21 23V20.6667C21 19.429 20.4732 18.242 19.5355 17.3668C18.5979 16.4917 17.3261 16 16 16H6C4.67392 16 3.40215 16.4917 2.46447 17.3668C1.52678 18.242 1 19.429 1 20.6667V23M16 6C16 8.76142 13.7614 11 11 11C8.23858 11 6 8.76142 6 6C6 3.23858 8.23858 1 11 1C13.7614 1 16 3.23858 16 6Z" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <p>Manage Users</p>
                    </a>
                </li>
                <!-- Element 02: Administer Locations -->
                <li class="ulSidebarItem">
                    <a href = "#" id = "navManageLocations">
                        <svg width="20" height="22" viewBox="0 0 20 22" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M7 21V11H13V21M1 8L10 1L19 8V19C19 19.5304 18.7893 20.0391 18.4142 20.4142C18.0391 20.7893 17.5304 21 17 21H3C2.46957 21 1.96086 20.7893 1.58579 20.4142C1.21071 20.0391 1 19.5304 1 19V8Z" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <p>Manage Locations</p>
                    </a>
                </li>
                <!-- Element 03: Administer Access -->
                <li class="ulSidebarItem">
                    <a href = "#" id = "navManageAccess">
                        <svg width="20" height="18" viewBox="0 0 20 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M5 10V6C5 4.67392 5.52678 3.40215 6.46447 2.46447C7.40215 1.52678 8.67392 1 10 1C11.3261 1 12.5979 1.52678 13.5355 2.46447C14.4732 3.40215 15 4.67392 15 6V10M3 10H17C18.1046 10 19 10.8954 19 12V19C19 20.1046 18.1046 21 17 21H3C1.89543 21 1 20.1046 1 19V12C1 10.8954 1.89543 10 3 10Z" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <p>Manage Access</p>
                    </a>
                </li>
                <!-- Element 04: Logs -->
                <li class="ulSidebarItem">
                    <a href = "#" id = "navLogs">
                        <svg width="20" height="14" viewBox="0 0 20 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M15 5H1M19 1H1M19 9H1M15 13H1" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <p>View Logs</p>
                    </a>
                </li>
                <!-- Element 05: Temparature -->
                <li class="ulSidebarItem">
                    <a href = "#" id = "navTemparature">
                        <svg width="23" height="22" viewBox="0 0 23 22" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M17 8H18C19.0609 8 20.0783 8.42143 20.8284 9.17157C21.5786 9.92172 22 10.9391 22 12C22 13.0609 21.5786 14.0783 20.8284 14.8284C20.0783 15.5786 19.0609 16 18 16H17M17 8H1V17C1 18.0609 1.42143 19.0783 2.17157 19.8284C2.92172 20.5786 3.93913 21 5 21H13C14.0609 21 15.0783 20.5786 15.8284 19.8284C16.5786 19.0783 17 18.0609 17 17V8ZM5 1V4M9 1V4M13 1V4" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <p>Temparature</p>
                    </a>
                </li>
                <!-- Element 05: Options -->
                <li class="ulSidebarItem">
                    <a href = "#">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12 15C13.6569 15 15 13.6569 15 12C15 10.3431 13.6569 9 12 9C10.3431 9 9 10.3431 9 12C9 13.6569 10.3431 15 12 15Z" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M19.4 15C19.2669 15.3016 19.2272 15.6362 19.286 15.9606C19.3448 16.285 19.4995 16.5843 19.73 16.82L19.79 16.88C19.976 17.0657 20.1235 17.2863 20.2241 17.5291C20.3248 17.7719 20.3766 18.0322 20.3766 18.295C20.3766 18.5578 20.3248 18.8181 20.2241 19.0609C20.1235 19.3037 19.976 19.5243 19.79 19.71C19.6043 19.896 19.3837 20.0435 19.1409 20.1441C18.8981 20.2448 18.6378 20.2966 18.375 20.2966C18.1122 20.2966 17.8519 20.2448 17.6091 20.1441C17.3663 20.0435 17.1457 19.896 16.96 19.71L16.9 19.65C16.6643 19.4195 16.365 19.2648 16.0406 19.206C15.7162 19.1472 15.3816 19.1869 15.08 19.32C14.7842 19.4468 14.532 19.6572 14.3543 19.9255C14.1766 20.1938 14.0813 20.5082 14.08 20.83V21C14.08 21.5304 13.8693 22.0391 13.4942 22.4142C13.1191 22.7893 12.6104 23 12.08 23C11.5496 23 11.0409 22.7893 10.6658 22.4142C10.2907 22.0391 10.08 21.5304 10.08 21V20.91C10.0723 20.579 9.96512 20.258 9.77251 19.9887C9.5799 19.7194 9.31074 19.5143 9 19.4C8.69838 19.2669 8.36381 19.2272 8.03941 19.286C7.71502 19.3448 7.41568 19.4995 7.18 19.73L7.12 19.79C6.93425 19.976 6.71368 20.1235 6.47088 20.2241C6.22808 20.3248 5.96783 20.3766 5.705 20.3766C5.44217 20.3766 5.18192 20.3248 4.93912 20.2241C4.69632 20.1235 4.47575 19.976 4.29 19.79C4.10405 19.6043 3.95653 19.3837 3.85588 19.1409C3.75523 18.8981 3.70343 18.6378 3.70343 18.375C3.70343 18.1122 3.75523 17.8519 3.85588 17.6091C3.95653 17.3663 4.10405 17.1457 4.29 16.96L4.35 16.9C4.58054 16.6643 4.73519 16.365 4.794 16.0406C4.85282 15.7162 4.81312 15.3816 4.68 15.08C4.55324 14.7842 4.34276 14.532 4.07447 14.3543C3.80618 14.1766 3.49179 14.0813 3.17 14.08H3C2.46957 14.08 1.96086 13.8693 1.58579 13.4942C1.21071 13.1191 1 12.6104 1 12.08C1 11.5496 1.21071 11.0409 1.58579 10.6658C1.96086 10.2907 2.46957 10.08 3 10.08H3.09C3.42099 10.0723 3.742 9.96512 4.0113 9.77251C4.28059 9.5799 4.48572 9.31074 4.6 9C4.73312 8.69838 4.77282 8.36381 4.714 8.03941C4.65519 7.71502 4.50054 7.41568 4.27 7.18L4.21 7.12C4.02405 6.93425 3.87653 6.71368 3.77588 6.47088C3.67523 6.22808 3.62343 5.96783 3.62343 5.705C3.62343 5.44217 3.67523 5.18192 3.77588 4.93912C3.87653 4.69632 4.02405 4.47575 4.21 4.29C4.39575 4.10405 4.61632 3.95653 4.85912 3.85588C5.10192 3.75523 5.36217 3.70343 5.625 3.70343C5.88783 3.70343 6.14808 3.75523 6.39088 3.85588C6.63368 3.95653 6.85425 4.10405 7.04 4.29L7.1 4.35C7.33568 4.58054 7.63502 4.73519 7.95941 4.794C8.28381 4.85282 8.61838 4.81312 8.92 4.68H9C9.29577 4.55324 9.54802 4.34276 9.72569 4.07447C9.90337 3.80618 9.99872 3.49179 10 3.17V3C10 2.46957 10.2107 1.96086 10.5858 1.58579C10.9609 1.21071 11.4696 1 12 1C12.5304 1 13.0391 1.21071 13.4142 1.58579C13.7893 1.96086 14 2.46957 14 3V3.09C14.0013 3.41179 14.0966 3.72618 14.2743 3.99447C14.452 4.26276 14.7042 4.47324 15 4.6C15.3016 4.73312 15.6362 4.77282 15.9606 4.714C16.285 4.65519 16.5843 4.50054 16.82 4.27L16.88 4.21C17.0657 4.02405 17.2863 3.87653 17.5291 3.77588C17.7719 3.67523 18.0322 3.62343 18.295 3.62343C18.5578 3.62343 18.8181 3.67523 19.0609 3.77588C19.3037 3.87653 19.5243 4.02405 19.71 4.21C19.896 4.39575 20.0435 4.61632 20.1441 4.85912C20.2448 5.10192 20.2966 5.36217 20.2966 5.625C20.2966 5.88783 20.2448 6.14808 20.1441 6.39088C20.0435 6.63368 19.896 6.85425 19.71 7.04L19.65 7.1C19.4195 7.33568 19.2648 7.63502 19.206 7.95941C19.1472 8.28381 19.1869 8.61838 19.32 8.92V9C19.4468 9.29577 19.6572 9.54802 19.9255 9.72569C20.1938 9.90337 20.5082 9.99872 20.83 10H21C21.5304 10 22.0391 10.2107 22.4142 10.5858C22.7893 10.9609 23 11.4696 23 12C23 12.5304 22.7893 13.0391 22.4142 13.4142C22.0391 13.7893 21.5304 14 21 14H20.91C20.5882 14.0013 20.2738 14.0966 20.0055 14.2743C19.7372 14.452 19.5268 14.7042 19.4 15Z" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <p>Settings</p>
                    </a>
                </li>
            </ul>
        </nav>
    </div>
    <div class="cContentSection">
        <div class = "cHeader">
            <h1 id = "hCorpName">Pumpkin Intl.</h1>
            <h1 id = "hCurView" > - Manage Users</h1>
            <p class = "paragraphHeaderDate"><%= "THIS IS JSP"  %></p>
        </div>
        <div class = "cMainContent">
            <!-- Global Spinning Bar -->
            <div class="cSpinnerLoading" id = "spinnerMainContent"></div>
            <!--Pages Content is inserted here-->
        </div>
    </div>
</div>

<script src="/js/navigation_ui.js"></script>
<script src="/js/navigation_ajax.js"></script>

</body>
</html>