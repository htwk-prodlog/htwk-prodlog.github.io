---
title: Projekte
icon: fas fa-diagram-project
order: 0
---

Entdecken Sie die Projekte unserer [GitHub-Organisation](https://github.com/htwk-prodlog). Hier erscheinen automatisch alle öffentlichen Repositories mit einer GitHub-Pages-Seite.

<style>
  .project-gallery { display: grid; grid-template-columns: repeat(auto-fit, minmax(min(100%, 17rem), 1fr)); gap: 1.25rem; margin: 1.75rem 0; }
  .project-card { display: flex; flex-direction: column; padding: 1.5rem; border: 1px solid var(--bs-border-color); border-radius: 0.85rem; background: var(--card-bg, var(--bs-body-bg)); transition: border-color .2s, transform .2s; }
  .project-card:hover { border-color: var(--link-color); transform: translateY(-3px); }
  .project-card h2 { font-size: 1.3rem; margin: 0 0 .75rem; overflow-wrap: anywhere; }
  .project-card p { flex: 1; margin: 0 0 1.5rem; }
  .project-card .project-language { font-size: .8rem; font-weight: 600; letter-spacing: .06em; text-transform: uppercase; margin-bottom: .75rem; }
  .project-links { display: flex; flex-wrap: wrap; gap: .75rem 1.25rem; }
</style>

{% if site.data.projects.size > 0 %}
<div class="project-gallery">
  {% for project in site.data.projects %}
  <article class="project-card">
    {% if project.language %}<span class="project-language text-muted">{{ project.language | escape }}</span>{% endif %}
    <h2>{{ project.name | escape }}</h2>
    <p>{{ project.description | default: 'Weitere Informationen auf der Projektseite und im Repository.' | escape }}</p>
    <div class="project-links">
      <a href="{{ project.pages_url | escape }}" aria-label="Projektseite von {{ project.name | escape }} öffnen">Projektseite <i class="fas fa-arrow-up-right-from-square" aria-hidden="true"></i></a>
      <a href="{{ project.repo_url | escape }}" aria-label="Quellcode von {{ project.name | escape }} ansehen">Quellcode</a>
    </div>
  </article>
  {% endfor %}
</div>
{% else %}
Derzeit sind keine veröffentlichten Projektseiten verfügbar.
{% endif %}
