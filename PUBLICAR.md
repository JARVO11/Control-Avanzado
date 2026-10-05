# Publicar en GitHub Pages

El paquete contiene el código fuente de un sitio Just the Docs. Destino: https://github.com/JARVO11/Control-Avanzado.

1. Crear o elegir un repositorio de Control Avanzado. No sobrescribir el portafolio de Integración Mecatrónica.
2. Copiar el CONTENIDO de esta carpeta a la raíz del repositorio (no la carpeta envolvente).
3. Editar `_config.yml`:

```yaml
url: "https://JARVO11.github.io"
baseurl: "/Control-Avanzado"
```

4. Subir los cambios a la rama elegida (por ejemplo, `main`).
5. En Settings → Pages elegir Deploy from a branch, la rama y `/ (root)`.
6. Revisar el resultado de Pages en Actions y abrir la URL indicada por GitHub.

Referencia: https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site

El repositorio existente se llama `Control-Avanzado`; conservar las mayúsculas en `baseurl`. Los enlaces usan `relative_url`. No crear un archivo `.nojekyll`: estas páginas necesitan el procesamiento de Jekyll. `vista-local/` está excluida del sitio publicado.

Antes de la entrega académica, completar integrantes, conexión del observador, región de activación, resultados y video. El paquete es una base documentada, no una certificación de cumplimiento experimental.
