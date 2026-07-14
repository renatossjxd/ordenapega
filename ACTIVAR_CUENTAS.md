# Activar cuentas reales en PegaLista

La pantalla nueva puede probarse de inmediato con **Explorar modo demostracion**. Para que distintas personas creen cuentas reales y usen sus datos desde cualquier dispositivo:

1. Cree un proyecto gratuito en Supabase.
2. Abra **SQL Editor**, copie todo el contenido de `database.sql` y ejecútelo una sola vez.
3. En **Project Settings > API**, copie la URL del proyecto y la clave publica o `anon`.
4. Abra `supabase-config.js` y complete:

```js
window.PEGALISTA_CONFIG = {
  supabaseUrl: 'URL_DEL_PROYECTO',
  supabaseKey: 'CLAVE_PUBLICA'
};
```

5. Publique la carpeta completa en un hosting HTTPS.

La clave publica puede utilizarse en el navegador. Nunca coloque la clave `service_role` en este archivo. Las politicas RLS de `database.sql` impiden que una cuenta vea datos pertenecientes a otra.

## Lo que queda separado por cuenta

- Perfil e identidad del negocio.
- Logo.
- Clientes.
- Cotizaciones y numeracion.
- Importes y estados.

Los PDF se crean desde la cotizacion mediante **Guardar como PDF / imprimir** e incluyen el logo y los datos del perfil que inicio sesion.
