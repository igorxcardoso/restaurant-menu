import { BrowserRouter, Routes, Route } from "react-router-dom";
import Home from "../pages/Home";
import { Header } from "../components/layout/Header";

export function AppRouter() {
  return (
    <BrowserRouter>
      <Header />
      <Routes>
        <Route path="/" element={<Home />} />
      </Routes>
    </BrowserRouter>
  );
}
