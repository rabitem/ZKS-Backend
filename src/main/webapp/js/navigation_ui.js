// Sidebar Collapse (Visual) -----------------------------------------------------------------

const objSidebarNavButton = document.querySelector(".cSidebarNavArrow");
const objSidebar          = document.querySelector(".cSidebar");

objSidebarNavButton.addEventListener("click", () => {
    
    objSidebar.classList.toggle("cSidebarClosed");

});

// Sidebar Item Select (Visual) ---------------------------------------------------------------

const objSidebarItems = document.querySelectorAll(".ulSidebarItem");

objSidebarItems.forEach((obj) => obj.addEventListener("click", updateSidebarSelectionVisuals));

function updateSidebarSelectionVisuals () {

    objSidebarItems.forEach((obj) => obj.classList.remove("ulSidebarItemActive"));

    this.classList.add("ulSidebarItemActive");
}

// Pop-Up Manage Users: Add User ---------------------------------------------------------------

const addUsersModal = document.querySelector("#popUpAddUser");
const addUserClose  = document.querySelector("#btnCloseAddUser");
const addUserStatus = document.querySelector("#pAddUserResponse");

function initializeAddUsers () {
 
    const addUserBtn = document.querySelector("#svgAddSign");
     
    addUserBtn.addEventListener("click", () => {
        addUsersModal.style.display = "block";
    });
}

addUserClose.addEventListener("click", () => {
    addUsersModal.style.display = "none";
    addUserStatus.style.display = "none";
});

// Pop-Up Manage Users: Remove User -----------------------------------------------------------

const removeUsersModal = document.querySelector("#popUpRemoveUser");
const removeUserClose  = document.querySelector("#btnCloseRemoveUser");
const removeUserStatus = document.querySelector("#pRemoveUserResponse");

function initializeRemoveUsers () {
 
    const removeUserBtn = document.querySelector("#svgRemoveSign");
     
    removeUserBtn.addEventListener("click", () => {
        removeUsersModal.style.display = "block";
    });

    buildDropdown("#cDropdownRemUser");
}

removeUserClose.addEventListener("click", () => {
    removeUsersModal.style.display = "none";
    removeUserStatus.style.display = "none";
});

// Pop-Up Add Location: -----------------------------------------------------------------------

const addLocationsModal = document.querySelector("#popUpAddLocation");
const addLocationClose  = document.querySelector("#btnCloseAddLocation");
const addLocationStatus = document.querySelector("#pAddLocationResponse");

function initializeAddLocations () {
 
    const addLocationBtn = document.querySelector("#svgAddSignLocation");
    
    // add new Location
    addLocationBtn.addEventListener("click", () => {
        addLocationsModal.style.display = "block";
    });
}

addLocationClose.addEventListener("click", () => {
    
    addLocationsModal.style.display = "none";
    addLocationStatus.style.display = "none";
});

// Pop-Up Remove Location: -----------------------------------------------------------------------

const removeLocationsModal = document.querySelector("#popUpRemoveLocation");
const removeLocationClose  = document.querySelector("#btnCloseRemoveLocation");
const removeLocationStatus = document.querySelector("#pRemoveLocationResponse");

function initializeRemoveLocations () {
 
    // try to remove existing Location
    const rmvLocationBtn = document.querySelector("#svgRemoveSignLocation");

    rmvLocationBtn.addEventListener("click", () => {
        removeLocationsModal.style.display = "block";    
    });

    buildDropdown("#cDropdownRemLocation");
}

removeLocationClose.addEventListener("click", () => {
    
    removeLocationsModal.style.display = "none";
    removeLocationStatus.style.display = "none";
    
});

// Pop-Up Add Authorizations ----------------------------------------------------------------

let addAuthsModal = null;

function initializeAddAuthorizations () {

    addAuthsModal       = document.querySelector("#popUpAddAuthorization");
    const manageAuthClose  = document.querySelector("#btnCloseManageAuthorization");
    const manageAuthStatus = document.querySelector("#pManageAuthorizationResponse");
    const addAuthBtn       = document.querySelector("#svgAddSignAuthorization");
        
    addAuthBtn.addEventListener("click", () => {
        addAuthsModal.style.display = "block";
    });

    manageAuthClose.addEventListener("click", () => {
    
        addAuthsModal.style.display = "none";
        manageAuthStatus.style.display = "none";
    });
}

// Pop-Up Remove Authorizations ----------------------------------------------------------------

let removeAuthsModal = null;

function initializeRemoveAuthorizations () {

    removeAuthsModal       = document.querySelector("#popUpRemoveAuthorization");
    const removeAuthClose  = document.querySelector("#btnCloseRemoveAuthorization");
    const removeAuthStatus = document.querySelector("#pRemoveAuthorizationResponse");
    const removeAuthBtn    = document.querySelector("#svgRemoveSignAuthorization");

    removeAuthBtn.addEventListener("click", () => {
        removeAuthsModal.style.display = "block";
    });

    removeAuthClose.addEventListener("click", () => {

        removeAuthsModal.style.display = "none";
        removeAuthStatus.style.display = "none";
    });
}

// close all pop-ups if user clicks outside of pop-up ui --------------------------------------

window.onmousedown = (event) => {

    if (event.target === addUsersModal) {

        addUsersModal.style.display = "none";
        addUserStatus.style.display = "none";
    }

    if (event.target === removeUsersModal) {

        removeUsersModal.style.display = "none";
        removeUserStatus.style.display = "none";
    }

    if (event.target === addLocationsModal) {

        addLocationsModal.style.display = "none";
        addLocationStatus.style.display = "none";
    }

    
    if (event.target === removeLocationsModal) {

        removeLocationsModal.style.display = "none";
        removeLocationStatus.style.display = "none";
    }

    if (addAuthsModal !== null && event.target === addAuthsModal) {
        
        const manageAuthStatus = document.querySelector("#pManageAuthorizationResponse");
        addAuthsModal.style.display = "none";
        manageAuthStatus.style.display = "none";
    }

    if (removeAuthsModal !== null && event.target === removeAuthsModal) {
        
        const removeAuthStatus = document.querySelector("#pRemoveAuthorizationResponse");
        removeAuthStatus.style.display = "none";
        removeAuthsModal.style.display = "none";
    }
}

// Bind static dropdowns, for existing html --------------------------------------------------

function bindStaticDropdowns(imTargetDropDownID) {

    const dropDownContainer = document.querySelector(imTargetDropDownID);
    const firstDropDownItem = dropDownContainer.querySelector(".pDropdownFirst");
    const dropDownContent   = dropDownContainer.querySelector(".cDropdownContent");
    const allDropDownItems = dropDownContent.querySelectorAll(".dropdownItem");

    // dropdown show
    dropDownContainer.addEventListener("mouseover", () => {
        dropDownContent.style.display = "block"
    });

    // dropdown hide
    dropDownContainer.addEventListener("mouseout", () => {
        dropDownContent.style.display = "none"
    });

    for (let i = 0; i < allDropDownItems.length; i++) {

        const dropDownItem = allDropDownItems[i];

        dropDownItem.addEventListener("click", () => {

            for (let j = 0; j < allDropDownItems.length; j++) {
                const obj = allDropDownItems[j];
                obj.style.fontWeight = "normal";
            }
    
            // make new selection bold
            dropDownItem.style.fontWeight = "bold";
    
            firstDropDownItem.innerHTML = dropDownItem.innerHTML;
            firstDropDownItem.setAttribute("data-id", dropDownItem.getAttribute("data-id"));
            dropDownContent.style.display = "none";
        });
    }
}

// Build dropdown - prev items are removed in ajax control ------------------------------------

function buildDropdown(imTargetDropDownID) {

    const dropDownContainer = document.querySelector(imTargetDropDownID);
    const firstDropDownItem = dropDownContainer.querySelector(".pDropdownFirst");
    const dropDownContent   = dropDownContainer.querySelector(".cDropdownContent");

    cleanDropdown(imTargetDropDownID);

    // dropdown show
    dropDownContainer.addEventListener("mouseover", () => {
        dropDownContent.style.display = "block"
    });

    // dropdown hide
    dropDownContainer.addEventListener("mouseout", () => {
        dropDownContent.style.display = "none"
    });

    // get existing data rows
    const dataRows = document.querySelectorAll("tr");

    // exclude header from data table
    if (dataRows.length <= 1) { return }

    for (let i = 1; i < dataRows.length; i++) {
        
        const dataObj = dataRows[i];
        const dataID  = dataObj.getAttribute("data-valueID");
        const label   = dataObj.getAttribute("data-name");
        
        // first element
        if (i === 1) {
            firstDropDownItem.innerHTML = label + " (" + dataID + ")";
            firstDropDownItem.setAttribute("data-id", dataID);
        }
        
        // insert dropdown item
        const newHTMLObj = document.createElement("p")

        newHTMLObj.innerHTML = label + " (" + dataID + ")";
        newHTMLObj.classList.add("dropdownItem");
        newHTMLObj.setAttribute("data-id", dataID);

        dropDownContent.appendChild(newHTMLObj);

        // dropdown click functionality
        newHTMLObj.addEventListener("click", () => {

            const allDropDownItems = dropDownContent.querySelectorAll(".dropdownItem");

            for (let j = 0; j < allDropDownItems.length; j++) {
                const obj = allDropDownItems[j];
                obj.style.fontWeight = "normal";
            }

            // make new selection bold
            newHTMLObj.style.fontWeight = "bold";

            firstDropDownItem.innerHTML = newHTMLObj.innerHTML;
            firstDropDownItem.setAttribute("data-id", newHTMLObj.getAttribute("data-id"));
            dropDownContent.style.display = "none";
        });
    }
}

// Deletes all items of dropdown div ----------------------------------------------------------

function cleanDropdown(imTargetDropDownID) {

    const dropDownContainer = document.querySelector(imTargetDropDownID);
    const dropDownContent   = dropDownContainer.querySelector(".cDropdownContent");
    const allDropDownItems  = dropDownContent.querySelectorAll(".dropdownItem");

    for (let i = 0; i < allDropDownItems.length; i++) {

        const dropDownItem = allDropDownItems[i];
        dropDownItem.remove();
    }
}

// Color Change for input on edit -------------------------------------------------------------

const keyColors = {
    
    colorPrimary: "#e9676e",
    colorTextPrimary: "#0a0c16",
    colorTextSecondary: "##11abd6"
}

function pInputOnFocus(imTargetID, imTargetLabel, imTargetLine) {

    document.getElementById(imTargetID).style.color       = keyColors.colorPrimary;
    document.getElementById(imTargetLabel).style.color    = keyColors.colorPrimary;
    document.getElementById(imTargetLine).style.transform = "scaleX(1)";

}

function pInputOnBlur(imTargetID, imTargetLabel, imTargetLine) {

    document.getElementById(imTargetID).style.color       = keyColors.colorTextSecondary;
    document.getElementById(imTargetLabel).style.color    = keyColors.colorTextSecondary;
    document.getElementById(imTargetLine).style.transform = "scaleX(0)";
    
}

// Pumpkin eat sound effect -------------------------------------------------------------------

const mightyPumpkin = document.querySelector("#pumpkin");
const sfx = new Audio("/sfx/minecraft_eating_sound_effect.mp3");

mightyPumpkin.addEventListener("click", () => {

    sfx.play();
});