<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Menu</title>
<style>
/* Defensive reset */
ul, li {
  margin: 0;
  padding: 0;
  list-style-type: none;
}

/* Menu container styles */
.navbar-container {
  position: relative;
  top: 0;
  background-color: #fff;
  z-index: 999;
  width: 100%;
  padding: 10px 20px;
  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.navbar-nav {
  display: flex !important;
  flex-direction: row !important;
  justify-content: flex-start;
  align-items: center;
  gap: 15px;
}

.nav-item {
  flex: 0 0 auto;
  position: relative;
}

.nav-item a {
  display: flex;
  align-items: center;
  text-decoration: none;
  color: #444;
  font-weight: 500;
  padding: 10px 15px;
  border-radius: 6px;
  transition: all 0.3s ease;
  background-color: transparent;
  font-size: 0.95rem;
}

.nav-item a:hover {
  background-color: #f0f7ff;
  color: #2a6fd6;
}

.nav-item.active a {
  background: linear-gradient(118deg, #2a6fd6, rgba(42, 111, 214, 0.7));
  box-shadow: 0 0 6px 1px rgba(42, 111, 214, 0.4);
  color: white !important;
}

.nav-item i {
  margin-right: 8px;
  width: 18px;
  height: 18px;
  stroke-width: 2;
}

/* Badge for notifications */
.nav-badge {
  position: absolute;
  top: -5px;
  right: -5px;
  background-color: #e74c3c;
  color: white;
  border-radius: 50%;
  width: 18px;
  height: 18px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.7rem;
  font-weight: bold;
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .navbar-nav {
    gap: 8px;
    overflow-x: auto;
    padding-bottom: 5px;
  }
  
  .navbar-nav::-webkit-scrollbar {
    height: 4px;
  }
  
  .navbar-nav::-webkit-scrollbar-thumb {
    background: #ddd;
    border-radius: 2px;
  }
  
  .nav-item a {
    padding: 8px 12px;
    font-size: 0.85rem;
  }
  
  .nav-item i {
    margin-right: 5px;
    width: 16px;
    height: 16px;
  }
}

/* Animation for active item */
@keyframes pulse {
  0% { box-shadow: 0 0 0 0 rgba(42, 111, 214, 0.4); }
  70% { box-shadow: 0 0 0 6px rgba(42, 111, 214, 0); }
  100% { box-shadow: 0 0 0 0 rgba(42, 111, 214, 0); }
}

.nav-item.active a {
  animation: pulse 1.5s infinite;
}
</style>
</head>
<body>
  <!-- Horizontal menu -->
  <div class="navbar-container">
    <ul class="navbar-nav" id="main-menu-navigation">
      <li class="nav-item" id="dashboard" url="<%= request.getContextPath() %>/att">
        <a href="<%= request.getContextPath() %>/att">
          <i data-feather="home"></i>Dashboard
        </a>
      </li>
      
      <li class="nav-item" id="users" url="<%= request.getContextPath() %>/users">
        <a href="<%= request.getContextPath() %>/home">
          <i data-feather="users"></i>Users
         <!--  <span class="nav-badge">3</span> -->
        </a>
      </li>
      
      <li class="nav-item" id="reports" url="<%= request.getContextPath() %>/home">
        <a href="<%= request.getContextPath() %>/leave-balance">
          <i data-feather="file-text"></i>Leave Balance
        </a>
      </li>
      <li class="nav-item" id="help" url="<%= request.getContextPath() %>/help">
        <a href="<%= request.getContextPath() %>/help-center">
          <i data-feather="help-circle"></i>Help
        </a>
      </li>
    </ul>
  </div>

  <script>
    document.addEventListener('DOMContentLoaded', function () {
      // Initialize feather icons
      if (window.feather) {
        feather.replace();
      }
      
      // Get current path and set active item
      const currentPath = window.location.pathname;
      const menuItems = document.querySelectorAll('.nav-item');
      
      // Clear all active classes first
      menuItems.forEach(item => item.classList.remove('active'));
      
      // Find matching menu item
      let activeItemFound = false;
      
      // Check localStorage first
      const selected = window.localStorage.getItem("selectedOption");
      if (selected && document.getElementById(selected)) {
        document.getElementById(selected).classList.add('active');
        activeItemFound = true;
      }
      
      // If no localStorage, check current URL
      if (!activeItemFound) {
        menuItems.forEach(item => {
          const itemUrl = item.getAttribute('url');
          if (itemUrl && currentPath.startsWith(itemUrl)) {
            item.classList.add('active');
            activeItemFound = true;
          }
        });
      }
      
      // If still not found, check URL patterns
      if (!activeItemFound) {
        if (currentPath.includes('/users')) {
          document.getElementById('users')?.classList.add('active');
        } else if (currentPath.includes('/att')) {
          document.getElementById('reports')?.classList.add('active');
        } else if (currentPath.includes('/home')) {
          document.getElementById('home')?.classList.add('active');
        } else if (currentPath.includes('/settings')) {
          document.getElementById('settings')?.classList.add('active');
        } else if (currentPath.includes('/help')) {
          document.getElementById('help')?.classList.add('active');
        } else {
          // Default to dashboard if nothing matches
          document.getElementById('dashboard')?.classList.add('active');
        }
      }
      
      // Set click handlers to update localStorage
      menuItems.forEach(item => {
        item.addEventListener('click', function () {
          localStorage.setItem("selectedOption", this.id);
          
          // Add slight delay to allow navigation before checking
          setTimeout(() => {
            const currentPath = window.location.pathname;
            const itemUrl = this.getAttribute('url');
            
            if (itemUrl && currentPath.startsWith(itemUrl)) {
              menuItems.forEach(i => i.classList.remove('active'));
              this.classList.add('active');
            }
          }, 100);
        });
      });
    });
  </script>

  <script src="https://unpkg.com/feather-icons"></script>
</body>
</html>