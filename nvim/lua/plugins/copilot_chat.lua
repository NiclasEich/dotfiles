return {
  "CopilotC-NVim/CopilotChat.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "github/copilot.vim" },
  cmd = { "CopilotChat", "CopilotChatOpen", "CopilotChatModel" },
  config = function()
    local chat = require("CopilotChat")
    local prompts = require("CopilotChat.config.prompts")
    local select = require("CopilotChat.select")

    local COPILOT_PLAN = [[
You are a software architect and technical planner focused on clear, actionable development plans.
]] .. prompts.COPILOT_BASE.system_prompt .. [[

When creating development plans:
- Start with a high-level overview
- Break down into concrete implementation steps
- Identify potential challenges and their solutions
- Consider architectural impacts
- Note required dependencies or prerequisites
- Estimate complexity and effort levels
- Track confidence percentage (0-100%)
- Format in markdown with clear sections

Always end with:
"Current Confidence Level: X%"
"Would you like to proceed with implementation?" (only if confidence >= 90%)
]]

    chat.setup({
      model = "gpt-4.1",
      debug = true,
      temperature = 0,
      sticky = "#buffers",
      mappings = {
        reset = false,
        show_diff = { full_diff = true },
      },
      prompts = {
        Explain  = { mapping = "<leader>ae", desc = "AI Explain" },
        Review   = { mapping = "<leader>ar", desc = "AI Review" },
        Tests    = { mapping = "<leader>at", desc = "AI Tests" },
        Fix      = { mapping = "<leader>af", desc = "AI Fix" },
        Optimize = { mapping = "<leader>ao", desc = "AI Optimize" },
        Docs     = { mapping = "<leader>ad", desc = "AI Documentation" },
        Commit   = { mapping = "<leader>ac", desc = "AI Generate Commit", selection = select.buffer },
        Plan = {
          prompt = "Create or update the development plan for the selected code. Focus on architecture, implementation steps, and potential challenges.",
          system_prompt = COPILOT_PLAN,
          context = "file:.copilot/plan.md",
          progress = function() return false end,
          callback = function(response, source)
            chat.chat:append("Plan updated successfully!", source.winnr)
            local plan_file = source.cwd() .. "/.copilot/plan.md"
            local dir = vim.fn.fnamemodify(plan_file, ":h")
            vim.fn.mkdir(dir, "p")
            local f = io.open(plan_file, "w")
            if f then f:write(response) f:close() end
          end,
        },
      },
      contexts = {
        -- Requires your local server & `cutils` helper exactly like your original config.
        vectorspace = {
          description = "Semantic search through workspace using vector embeddings. Find relevant code with natural language queries.",
          schema = {
            type = "object",
            required = { "query" },
            properties = {
              query = { type = "string",  description = "Natural language query to find relevant code." },
              max   = { type = "integer", description = "Maximum number of results to return.", default = 10 },
            },
          },
          resolve = function(input, source, prompt)
            local embeddings = cutils.curl_post("http://localhost:8000/query", {
              json_request = true, json_response = true,
              body = { dir = source.cwd(), text = input.query or prompt, max = input.max },
            }).body

            cutils.schedule_main()
            return vim.iter(embeddings)
              :map(function(e) e.filetype = cutils.filetype(e.filename); return e end)
              :filter(function(e) return e.filetype end)
              :totable()
          end,
        },
      },
      providers = { github_models = { disabled = false } },
    })
  end,
}

