import "./Header.css";

export function Header() {
  const menuItems = [
    { name: "Home", link: "/" },
  ];

  return (
    <header className="header">
      <div className="logo">RM</div>
      <nav className="nav-links">
        {menuItems.map((item, index) => (
          <a key={index} href={item.link}>
            {item.name}
          </a>
        ))}
      </nav>
      <button className="login-btn">Login</button>
    </header>
  );
}
