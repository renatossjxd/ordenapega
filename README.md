# OrdenaPega

**Cotiza. Trabaja. Cobra.**

Plataforma web para trabajadores independientes y pymes de servicios en Chile.

## Funciones

- Registro e inicio de sesión con Supabase.
- Datos privados y separados por cuenta mediante RLS.
- Perfil comercial, rubro y logo por negocio.
- Clientes, cotizaciones y seguimiento comercial.
- Documentos personalizados listos para PDF.
- Panel con cobros, conversión y flujo mensual.
- Prueba gratuita de 14 días y plan mensual mediante Mercado Pago.
- Diseño adaptable a computador y celular.

## Configuración

1. Crear un proyecto en Supabase.
2. Ejecutar `database.sql` en SQL Editor.
3. Ejecutar `subscription-migration.sql` una vez.
4. Completar la URL y clave publicable en `supabase-config.js`.
5. Configurar el enlace público de Mercado Pago en `billing-config.js`.
6. Publicar estos archivos en un hosting HTTPS.

Nunca se debe colocar una clave `service_role`, `sb_secret_` o Access Token de Mercado Pago en el navegador o repositorio.

## Desarrollo local

Sirva esta carpeta mediante un servidor HTTP local y abra `index.html`. Abrir los archivos directamente puede impedir algunas funciones de autenticación.

## Estado

MVP en desarrollo. El webhook seguro para activar automáticamente las suscripciones pagadas debe configurarse antes del lanzamiento público.
