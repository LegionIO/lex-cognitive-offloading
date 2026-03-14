# lex-cognitive-offloading

Extended cognition / cognitive offloading model for LegionIO agents. Delegate items to external stores (database, file, agent, tool, etc.) with trust tracking. Successful retrievals boost store trust; failures decay it.

## What It Does

- Seven store types: `database`, `file`, `agent`, `tool`, `memory_aid`, `external_service`, `notes`
- Register stores with initial trust scores
- Offload items with importance ratings to specific stores
- Retrieve items and automatically record success (trust boost)
- Report retrieval failures to decay store trust
- Track offloading ratio, overall store trust, and most important offloaded items
- Identify unreliable stores (trust below threshold)

## Usage

```ruby
# Register external stores
runner.register_store(name: 'project_db', store_type: :database, trust: 0.9)
runner.register_store(name: 'teammate_agent', store_type: :agent, trust: 0.7)

# Offload items
runner.offload_item(content: 'deployment checklist step 4',
                     item_type: :procedural, store_id: db_id, importance: 0.8)

# Retrieve successfully
runner.retrieve_item(item_id: item_id)
# => { success: true, item: { ... }, store_trust_after: 0.75 }

# Report a failure
runner.report_retrieval_failure(item_id: other_item_id)
# => { success: true, store_trust_after: 0.68 }

# Status
runner.offloading_status
# => { success: true, total_items: 1, offloading_ratio: 0.002, overall_store_trust: 0.79, unreliable_stores: [] }
```

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT
