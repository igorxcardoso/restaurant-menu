import { useState, useEffect } from 'react';
import './Home.css';

export default function Home() {
  const [restaurants, setRestaurants] = useState([]);
  const [searchTerm, setSearchTerm] = useState('');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchRestaurants = async () => {
      try {
        const apiUrl = import.meta.env.VITE_API_URL;
        const response = await fetch(`${apiUrl}/api/v1/restaurants`);
        
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const data = await response.json();
        setRestaurants(data.restaurants);

      } catch (e) {
        console.error("Falha ao buscar dados da API:", e);
        setError("Não foi possível carregar os menus. Verifique sua conexão ou a API.");
      
      } finally {
        setLoading(false);
      }
    };

    fetchRestaurants();
  }, []);

  // Currency format
  const formatPrice = (price) => {
    return price.toLocaleString('en-US', {
      style: 'currency',
      currency: 'USD',
    });
  };

  const filteredRestaurants = restaurants.filter(restaurant => {
    const term = searchTerm.toLowerCase();
    const matchesRestaurantName = restaurant.name.toLowerCase().includes(term);

    const matchesMenuItem = restaurant.menus.some(menu =>
      menu.menu_items.some(item =>
        item.name.toLowerCase().includes(term)
      )
    );

    return matchesRestaurantName || matchesMenuItem;
  });

  const renderContent = () => {
    if (loading) {
      return <div className="loading-message">Carregando menus...</div>;
    }
    
    if (error) {
      return <div className="error-message">{error}</div>;
    }

    if (filteredRestaurants.length > 0) {
      return (
        <div className="restaurants-grid">
          {filteredRestaurants.map((restaurant) => (
            <div key={restaurant.name} className="restaurant-card">
              <h2>{restaurant.name}</h2>
              {restaurant.menus.map((menu) => (
                <div key={menu.name} className="menu-section">
                  <h3>{menu.name}</h3>
                  <ul>
                    {menu.menu_items.map((item) => (
                      <li key={`${item.name}-${item.price}`}>
                        <span>{item.name}</span>
                        <span className="price">{formatPrice(item.price)}</span>
                      </li>
                    ))}
                  </ul>
                </div>
              ))}
            </div>
          ))}
        </div>
      );
    }
    
    return <div className="no-results-message">No results found.</div>;
  };

  return (
    <div className="app-container">
      <header>
        <h1>Menus 🍽️</h1>
        <input
          type="text"
          placeholder="Search for a restaurant or dish..."
          className="search-input"
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
        />
      </header>

      <main>
        {renderContent()}
      </main>
    </div>
  );
}
