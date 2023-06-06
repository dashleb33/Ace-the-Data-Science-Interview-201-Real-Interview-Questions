import plotly.graph_objs as go
import pandas as pd

# Replace 'df' with the name of your dataframe
df = pd.DataFrame({
    'org_id': [1, 2, 3, 4, 5, 6],
    'org_nm': ['A', 'B', 'C', 'D', 'E', 'F'],
    'parent_org_id': [None, 1, 1, 2, 2, 3],
    'parent_org_nm': [None, 'A', 'A', 'B', 'B', 'C'],
    'org_level': [1, 2, 2, 3, 3, 3]
})

# Create a list of nodes for the Sankey chart
nodes = []
for org in df['org_nm'].unique():
    nodes.append({'label': org})
for parent_org in df['parent_org_nm'].unique():
    if parent_org is not None:
        nodes.append({'label': parent_org})

# Create a list of links for the Sankey chart
links = []
for index, row in df.iterrows():
    org_node = nodes.index({'label': row['org_nm']})
    if row['parent_org_nm'] is not None:
        parent_node = nodes.index({'label': row['parent_org_nm']})
        links.append({'source': parent_node, 'target': org_node, 'value': 1})

# Create the Sankey chart
fig = go.Figure(data=[go.Sankey(node=dict(label=nodes[i]['label'], pad=15, thickness=20), 
                                 link=dict(source=links[i]['source'], 
                                           target=links[i]['target'], 
                                           value=links[i]['value'])) for i in range(len(links))])

fig.update_layout(title_text="Organizational Structure",
                  font=dict(size=12, color='black'),
                  height=800, width=1200)

fig.show()
