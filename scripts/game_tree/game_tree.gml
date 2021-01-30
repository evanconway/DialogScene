// Game Tree
/*
The game tree was designed specifically for creating dialog trees. But it could be used for
anything that uses the same structure. After creating a game tree, the tree can be 
populated with a specific style of programming.
*/

function game_tree() constructor{
	/*
	Each element in the tree is an array containing:
	[branch, branch_depth, data, targets]
	*/
	tree = [];
	state = 0;
	
	branch = -1; // integer id of branch of each step, for creation only
	
	/*
	In our design, "depth" is not traditional tree depth. Instead we think of the first 
	branch as being on the main "depth". Each branch that deviates from this first depth
	is considered to be one depth lower. Think of depth as how far a branch has deviated
	from the original branch. 
	*/
	branch_depth = 0; // depth of each step, creation only
	create_new_branch = true; // flag for creating new branch, creation only
	
	/// @func add(data, *branches...)
	add = function(_data) {
		
		/*
		The optional *branches... parameter is for functions that also populate the tree.
		They are executed as sub trees of the current tree. The add function is designed
		this way so the code visually looks like the tree as you're making it. This makes
		it easier to make changes right in game maker on the fly. 
		*/
	
		if (create_new_branch) branch++;
		
		var step = { branch: branch, branch_depth: branch_depth, data: _data, targets: [] }; // the branch id could be WRONG if new branch wasn't created
		var step_prev = array_length(tree) > 0 ? tree[array_length(tree) - 1] : undefined;
		
		// correct step branch id
		if (step_prev != undefined && !create_new_branch) {
			// find last step with same depth as current step
			var last_same_depth = array_length(tree) - 1;
			while (tree[last_same_depth].branch_depth != step.branch_depth) last_same_depth--;
			step.branch = tree[last_same_depth].branch;
		}
		
		array_push(tree, step);
		if (step_prev == undefined) {
			// End function if first step. We have to set new branch flag to false here because we never make it to the normal setter at the bottom.
			create_new_branch = false;
			return;
		}
		var curr_step_id = array_length(tree) - 1;
		
		// After adding the newest step. The targets of the previous step(s) must be determined.
		
		// If the previous step is in the same branch as the current, add current step index as target of previous step.
		if (step_prev.branch == step.branch) {
			array_push(step_prev.targets, curr_step_id);
		}
		
		// If the current step is the beginning of a branch, add the current step index as a target for the last step in the next highest depth. 
		if (create_new_branch) {
			// find last step in higher depth (remember lower number is higher depth)
			var last_high_depth = curr_step_id;
			while (tree[last_high_depth].branch_depth != branch_depth - 1) last_high_depth--;
			array_push(tree[last_high_depth].targets, curr_step_id);
		}
		
		// If the previous step's depth is one lower than current (and current is not a new branch), add current index as target for steps with empty target arrays between current, and last step in current depth.
		if (step_prev.branch_depth == branch_depth + 1 && !create_new_branch) {
			// find last step with same depth as current
			var i_backwards = curr_step_id - 1;
			while (tree[i_backwards].branch_depth != branch_depth) {
				if (array_length(tree[i_backwards].targets) <= 0) {
					array_push(tree[i_backwards].targets, curr_step_id);
				}
				i_backwards--;
			}
		}
		
		// execute branch functions
		var branch_original_depth = branch_depth;
		for (var i = 1; i < argument_count; i++) {
			branch_depth = branch_original_depth + 1;
			create_new_branch = true;
			method(undefined, argument[i])();
		}
		branch_depth = branch_original_depth;
		
		// always reset create new branch.
		create_new_branch = false
	}
	
	/// @desc Set state to next target. 0 assumed if none given.
	/// @func tree_advance(*target)
	tree_advance = function() {
		// do not advance if at end of tree
		if (array_length(tree[state].targets) <= 0) return;
		var target = argument_count >= 1 ? argument[0] : 0;
		state = tree[state].targets[target];
	}
	
	/// @desc Return data at trees current state.
	/// @func tree_get_data()
	tree_get_data = function() {
		return tree[state].data;
	}
}
