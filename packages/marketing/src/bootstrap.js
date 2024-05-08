import React, { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import App from "./App";



// Mount function to start the app
const mount = (el) => {
  const root = createRoot(el);
  root.render(
    <StrictMode>
      <App />
    </StrictMode>
  );
}

// if we are in development and in isolation,
// call mount immediately
if (process.env.NODE_ENV === 'development') {
  const devRoot = document.querySelector('#_marketing-dev-root')

  if (devRoot) {
    mount(devRoot)
  }
}

// We are running through the container 
// and we should export the mount function

export { mount };