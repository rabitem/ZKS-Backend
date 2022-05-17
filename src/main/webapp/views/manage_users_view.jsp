<%@ page import = "java.sql.*" %>

<div class="cMainContentManageUsers" id = "cMainContentSubFolder">
    <div class="cAdjustments cMainBox">
        <h2>Manage Users</h2>
        <div class="cOptions">
            <p>Add Users</p>
            <svg id = "svgAddSign" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M10 6V14M6 10H14M3 1H17C18.1046 1 19 1.89543 19 3V17C19 18.1046 18.1046 19 17 19H3C1.89543 19 1 18.1046 1 17V3C1 1.89543 1.89543 1 3 1Z" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            <p>Remove Users</p>
            <svg id = "svgRemoveSign" width="21" height="21" viewBox="0 0 21 21" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M7.50562 7.69464L13.5056 13.6946M13.5056 7.69464L7.50562 13.6946M3.50562 1.69464H17.5056C18.6102 1.69464 19.5056 2.59007 19.5056 3.69464V17.6946C19.5056 18.7992 18.6102 19.6946 17.5056 19.6946H3.50562C2.40105 19.6946 1.50562 18.7992 1.50562 17.6946V3.69464C1.50562 2.59007 2.40105 1.69464 3.50562 1.69464Z" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>                                
        </div>        
    </div>
    <div class="cTableContent cMainBox">
        <h2>User Data</h2>
        <table>
            <tr>
                <th>User Name</th>
                <th>User Role</th>
                <th>User RFID</th>
                <th>Current Location</th>
            </tr>
            <!-- Generated JSP Content -->
            <% 
            try {
            
                Class.forName("org.mariadb.jdbc.Driver");
            
                Connection connection=DriverManager.getConnection("jdbc:mariadb://localhost:3306/ZKS_Database","kilian","start123");
                        
                Statement stmt = connection.createStatement();
            
                ResultSet rslt = stmt.executeQuery("SELECT u.name, u.rfid, r.label as role, l.label as location FROM user as u INNER JOIN role as r ON u.role = r.id INNER JOIN location as l ON u.current_loc = l.id;");
            
                while (rslt.next()) {  %>

                    <tr>
                        <td><%= rslt.getString(0) %></td>
                        <td><%= rslt.getString(1) %></td>
                        <td><%= rslt.getString(2) %></td>
                        <td><%= rslt.getString(3) %></td>
                    </tr>
            
                 <% }
            
                    stmt.close();
                    connection.close();

                } catch (Exception e) {
                    
                    out.println(e);
                }
            %>

        </table>
    </div>
</div>