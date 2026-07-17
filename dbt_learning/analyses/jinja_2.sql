{%- set apples = [ 
    "red delicious", 
    "granny smith", 
    "honeycrisp", 
    "fuji", 
    "gala" 
]
-%}

{%- for apple in apples -%}
    {% if apple != "gala" %}
        {{ apple }}
    {% else %}
        {{ apple }} is not my favorite apple.
    {% endif %}
{% endfor %}