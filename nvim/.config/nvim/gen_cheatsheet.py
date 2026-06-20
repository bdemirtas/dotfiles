from pathlib import Path

from reportlab.lib import colors
from reportlab.lib.pagesizes import A4, landscape
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.units import mm
from reportlab.platypus import HRFlowable, Paragraph, SimpleDocTemplate, Spacer, Table, TableStyle

BG = colors.HexColor("#1e2030")
BORDER = colors.HexColor("#444a73")
ACCENT = colors.HexColor("#82aaff")
GREEN = colors.HexColor("#c3e88d")
FG = colors.HexColor("#c8d3f5")
MUTED = colors.HexColor("#7a88cf")
ROW2 = colors.HexColor("#252837")

W, H = landscape(A4)

title_style = ParagraphStyle(
    "title", fontName="Helvetica-Bold", fontSize=20, textColor=GREEN, alignment=1, spaceAfter=2
)
subtitle_style = ParagraphStyle(
    "sub", fontName="Helvetica", fontSize=9, textColor=MUTED, alignment=1, spaceAfter=8
)
key_style = ParagraphStyle(
    "key", fontName="Courier-Bold", fontSize=7.5, textColor=ACCENT, leading=10
)
desc_style = ParagraphStyle("desc", fontName="Helvetica", fontSize=7.5, textColor=FG, leading=10)
note_style = ParagraphStyle(
    "note", fontName="Helvetica-Oblique", fontSize=7, textColor=MUTED, alignment=1
)
hdr_style = ParagraphStyle("hdr", fontName="Helvetica-Bold", fontSize=8, textColor=BG, leading=11)


def kp(text):
    return Paragraph(text, key_style)


def dp(text):
    return Paragraph(text, desc_style)


ALL_GROUPS = [
    ("General", [
        ("<Esc>", "Clear search highlights"),
        ("<leader>q", "Quit"),
        ("<leader>w", "Save"),
        ("<leader>W", "Save all"),
        ("<leader>p", "Paste without yanking (visual)"),
    ]),
    ("Navigation", [
        ("<C-d> / <C-u>", "Scroll down / up (centered)"),
        ("<C-h/j/k/l>", "Window left / down / up / right"),
        ("<C-Up/Down>", "Resize window height"),
        ("<C-Left/Right>", "Resize window width"),
        ("<A-j> / <A-k>", "Move line down / up"),
    ]),
    ("Buffers", [
        ("<S-h> / <S-l>", "Prev / Next buffer"),
        ("[b / ]b", "Prev / Next buffer"),
        ("<leader>bd", "Delete buffer"),
        ("<leader>bo", "Delete other buffers"),
        ("<leader>br", "Delete right buffers"),
        ("<leader>bl", "Delete left buffers"),
        ("<leader>bp", "Pin buffer"),
    ]),
    ("Editing & Surround", [
        ("<Tab> / <S-Tab>", "Indent / Unindent"),
        ("gsa", "Add surround"),
        ("gsd", "Delete surround"),
        ("gsr", "Replace surround"),
        ("gsf / gsF", "Find surround right / left"),
        ("<M-e>", "Autopair fast wrap"),
    ]),
    ("Flash (Motion)", [
        ("s", "Flash jump"),
        ("S", "Flash treesitter"),
        ("r", "Flash remote (operator)"),
        ("R", "Flash treesitter search"),
        ("<C-s>", "Toggle flash in / search"),
    ]),
    ("Misc", [
        ("<leader>uu", "Undo tree"),
    ]),
    ("Code & LSP", [
        ("<leader>cf", "Format buffer"),
        ("<leader>cd", "Show diagnostic float"),
        ("<leader>cs", "Symbols (Trouble)"),
        ("<leader>cl", "LSP references (Trouble)"),
        ("[d / ]d", "Prev / Next diagnostic"),
    ]),
    ("Coverage", [
        ("<leader>cL", "Load coverage (lcov.info)"),
        ("<leader>cv", "Toggle coverage signs"),
        ("<leader>cS", "Coverage summary"),
    ]),
    ("Debug", [
        ("<leader>db", "Toggle breakpoint"),
        ("<leader>dB", "Conditional breakpoint"),
        ("<leader>dT", "Debug pytest at cursor"),
        ("<leader>dF", "Debug pytest file"),
        ("<leader>dc", "Continue / start debug"),
        ("<leader>ds", "Step over"),
        ("<leader>di", "Step into"),
        ("<leader>do", "Step out"),
        ("<leader>dt", "Terminate debug"),
        ("<leader>du", "Toggle debug UI"),
        ("<leader>dr", "Open debug REPL"),
    ]),
    ("CI/CD", [
        ("<leader>ci", "Open pipeline panel"),
        (":Pipeline", "Toggle CI/CD panel"),
        ("statusline", "Pipeline status (right side)"),
    ]),
    ("Git", [
        ("<leader>gg", "Open Neogit"),
        ("<leader>gc", "Commit"),
        ("<leader>gp", "Push"),
        ("<leader>gl", "Pull"),
        ("<leader>gt", "Time machine (Tardis)"),
        ("<leader>gd", "Diff working tree"),
        ("<leader>gdm", "Diff from main (PR view)"),
        ("<leader>gdh", "Diff last commit"),
    ]),
    ("Git Hunks", [
        ("]h / [h", "Next / Prev hunk"),
        ("]H / [H", "Last / First hunk"),
        ("<leader>hs", "Stage hunk"),
        ("<leader>hr", "Reset hunk"),
        ("<leader>hS", "Stage buffer"),
        ("<leader>hR", "Reset buffer"),
        ("<leader>hu", "Undo stage hunk"),
        ("<leader>hp", "Preview hunk"),
        ("<leader>hb", "Blame line"),
        ("<leader>hd", "Diff this"),
    ]),
    ("Search & Notifications", [
        ("<leader>sr", "Search & Replace (grug-far)"),
        ("<leader>sn", "Noice message history"),
        ("<leader>snl", "Noice last message"),
        ("<leader>snd", "Dismiss notifications"),
    ]),
    ("Diagnostics / Trouble", [
        ("<leader>xx", "Toggle diagnostics"),
        ("<leader>xX", "Toggle buffer diagnostics"),
        ("<leader>xL", "Location list"),
        ("<leader>xQ", "Quickfix list"),
    ]),
    ("Multicursor", [
        ("<C-n>", "Add cursor at next match"),
        ("<C-p>", "Add cursor at prev match"),
        ("<C-q>", "Toggle cursor manually"),
        ("<C-h>  [layer]", "Switch to prev cursor"),
        ("<C-l>  [layer]", "Switch to next cursor"),
        ("<C-x>  [layer]", "Delete cursor"),
        ("<Esc>  [layer]", "Enable / clear all cursors"),
    ]),
    ("Completion (blink.cmp)", [
        ("<C-j> / <C-k>", "Select next / prev item"),
        ("<CR>", "Accept"),
        ("<C-CR>", "Show / hide docs"),
        ("<C-e>", "Hide menu"),
        ("<C-b> / <C-f>", "Scroll docs up / down"),
        ("<Tab> / <S-Tab>", "Snippet forward / backward"),
    ]),
]

COL_W = (W - 24 * mm) / 2
KEY_W = 52
DESC_W = COL_W - KEY_W - 2


def bg_canvas(canvas, _doc):
    canvas.saveState()
    canvas.setFillColor(BG)
    canvas.rect(0, 0, W, H, fill=1, stroke=0)
    canvas.restoreState()


split = len(ALL_GROUPS) // 2
left_groups = ALL_GROUPS[:split]
right_groups = ALL_GROUPS[split:]


def build_col_data(groups):
    rows = []
    is_header = []
    is_spacer = []
    for title, grp_rows in groups:
        rows.append((Paragraph(f"  {title}", hdr_style), ""))
        is_header.append(True)
        is_spacer.append(False)
        for key, desc in grp_rows:
            rows.append((kp(key), dp(desc)))
            is_header.append(False)
            is_spacer.append(False)
        rows.append(("", ""))
        is_header.append(False)
        is_spacer.append(True)
    return rows, is_header, is_spacer


left_rows, left_hdr, left_sp = build_col_data(left_groups)
right_rows, right_hdr, right_sp = build_col_data(right_groups)

max_len = max(len(left_rows), len(right_rows))
while len(left_rows) < max_len:
    left_rows.append(("", ""))
    left_hdr.append(False)
    left_sp.append(True)
while len(right_rows) < max_len:
    right_rows.append(("", ""))
    right_hdr.append(False)
    right_sp.append(True)

data = []
for i in range(max_len):
    lk, ld = left_rows[i]
    rk, rd = right_rows[i]
    data.append([lk, ld, rk, rd])

style_cmds = [
    ("LEFTPADDING", (0, 0), (-1, -1), 5),
    ("RIGHTPADDING", (0, 0), (-1, -1), 5),
    ("TOPPADDING", (0, 0), (-1, -1), 2),
    ("BOTTOMPADDING", (0, 0), (-1, -1), 2),
    ("VALIGN", (0, 0), (-1, -1), "MIDDLE"),
    ("LINEAFTER", (1, 0), (1, -1), 1, colors.HexColor("#555a8a")),
    ("LEFTPADDING", (2, 0), (2, -1), 10),
]

row_idx_l = 0
for i in range(max_len):
    if left_hdr[i]:
        style_cmds.extend(
            [
                ("BACKGROUND", (0, i), (1, i), ACCENT),
                ("SPAN", (0, i), (1, i)),
                ("TOPPADDING", (0, i), (1, i), 3),
                ("BOTTOMPADDING", (0, i), (1, i), 3),
            ]
        )
    elif left_sp[i]:
        style_cmds.extend(
            [
                ("BACKGROUND", (0, i), (1, i), BG),
                ("TOPPADDING", (0, i), (1, i), 1),
                ("BOTTOMPADDING", (0, i), (1, i), 1),
            ]
        )
    else:
        bg = BG if row_idx_l % 2 == 0 else ROW2
        style_cmds.extend(
            [
                ("BACKGROUND", (0, i), (1, i), bg),
                ("GRID", (0, i), (1, i), 0.2, BORDER),
            ]
        )
        row_idx_l += 1

    if right_hdr[i]:
        style_cmds.extend(
            [
                ("BACKGROUND", (2, i), (3, i), ACCENT),
                ("SPAN", (2, i), (3, i)),
                ("TOPPADDING", (2, i), (3, i), 3),
                ("BOTTOMPADDING", (2, i), (3, i), 3),
            ]
        )
    elif right_sp[i]:
        style_cmds.extend(
            [
                ("BACKGROUND", (2, i), (3, i), BG),
                ("TOPPADDING", (2, i), (3, i), 1),
                ("BOTTOMPADDING", (2, i), (3, i), 1),
            ]
        )
    else:
        bg = BG if i % 2 == 0 else ROW2
        style_cmds.extend(
            [
                ("BACKGROUND", (2, i), (3, i), bg),
                ("GRID", (2, i), (3, i), 0.2, BORDER),
            ]
        )

big_table = Table(data, colWidths=[KEY_W, DESC_W, KEY_W + 8, DESC_W - 8], repeatRows=0)
big_table.setStyle(TableStyle(style_cmds))

out = Path(__file__).resolve().parent / "nvim-cheatsheet.pdf"
doc = SimpleDocTemplate(
    str(out),
    pagesize=landscape(A4),
    leftMargin=12 * mm,
    rightMargin=12 * mm,
    topMargin=10 * mm,
    bottomMargin=10 * mm,
)

story = [
    Paragraph("Neovim Keybindings", title_style),
    Paragraph("burak's config  •  leader = Space", subtitle_style),
    HRFlowable(width="100%", thickness=0.5, color=BORDER, spaceAfter=6),
    big_table,
    Spacer(1, 4),
    HRFlowable(width="100%", thickness=0.5, color=BORDER, spaceBefore=2),
    Paragraph(
        "Pytest: cursor in def test_* → <leader>db → <leader>dT  •  "
        "CI/CD: gh auth login once, then <leader>ci  •  "
        "[layer] = multicursor active",
        note_style,
    ),
]

doc.build(story, onFirstPage=bg_canvas, onLaterPages=bg_canvas)
print(f"Written: {out}")